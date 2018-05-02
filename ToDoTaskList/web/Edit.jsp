<%@page language="java" import="java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Task</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.6 -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <script>
        function deleteT()
        {

            var r = confirm("You want to Delete..!");
            if (r == true)
            {
                var sid = document.getElementById('ss').value;              
                location.href = 'TaskAction?page=DeleteTask&sid=' + sid;
            } else
            {

            }

        }
        
        function editT()
        {

            var r = confirm("You want to Edit..!");
            if (r == true)
            {
                var sid = document.getElementById('ss').value;
                var t = document.getElementById('title').value;
                var d = document.getElementById('desc').value;                
                location.href = 'TaskAction?page=EditTask&title='+t+'&desc='+d+'&sid=' + sid;
            } else
            {

            }

        }

    </script>
    <body class="hold-transition skin-blue sidebar-mini">
        <!-- Site wrapper -->
        <div class="wrapper">

            <header class="main-header">
                <!-- Logo -->
                <a href="index2.html" class="logo">
                    <!-- mini logo for sidebar mini 50x50 pixels -->
                    <span class="logo-mini"><b>T</b>L</span>
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg"><b>ToDo</b>List</span>
                </a>
                <!-- Header Navbar: style can be found in header.less -->
                <nav class="navbar navbar-static-top">
                    <!-- Sidebar toggle button-->
                    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>

                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">     

                            <!-- User Account: style can be found in dropdown.less -->
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="dist/img/avatar5.png" class="user-image" alt="User Image">
                                    <span class="hidden-xs">Alexander Pierce</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <!-- User image -->
                                    <li class="user-header">
                                        <img src="dist/img/avatar5.png" class="img-circle" alt="User Image">

                                        <p>
                                            Alexander Pierce - Web Developer
                                        </p>
                                    </li>
                                    <li class="user-footer">                
                                        <div class="pull-right">
                                            <a href="#" class="btn btn-default btn-flat">Sign out</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>          
                        </ul>
                    </div>
                </nav>
            </header>

            <!-- =============================================== -->

            <!-- Left side column. contains the sidebar -->
            <aside class="main-sidebar">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="dist/img/avatar5.png" class="img-circle" alt="User Image">
                        </div>
                        <div class="pull-left info">
                            <p>Alexander Pierce</p>
                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        <li class="header">MAIN NAVIGATION</li>
                        <li>
                            <a href="Task.jsp">
                                <i class="fa fa-laptop"></i> <span>Task</span>
                            </a>
                        </li>
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- =============================================== -->

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">


                <!-- Main content -->
                <section class="content">

                    <!-- Default box -->
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Task Maker</h3>

                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fa fa-minus"></i></button>
                                <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
                                    <i class="fa fa-times"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <!-- /.box-header -->

                            <form role="form" method="get" action="TaskAction">
                                <%
                                    Connection con = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;
                                    int id = Integer.parseInt(request.getParameter("sid"));
                                    String title, desc;
                                    try {
                                        con = task.Connect.makeConnection();
                                        String query = "select * from task where task_id =" + id;
                                        ps = con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                            
                                            title = rs.getString(2);
                                            desc = rs.getString(3);


                                %><!-- text input -->
                                <input type="hidden" name="sid" value="<%=id%>" id="ss"/>
                                <div class="form-group">
                                    <label>Title</label>
                                    <input type="text" name="title" id="title" class="form-control" value="<%=title%>" placeholder="Enter ...">
                                </div>             

                                <!-- textarea -->
                                <div class="form-group">
                                    <label>description</label>
                                    <textarea class="form-control" rows="2" name="desc" id="desc" value="" placeholder="Enter ..."><%=desc%></textarea>
                                </div>  
                                <%}

                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>   
                                <div class="box-footer">
                                    <center><input type="button" name="update" value="Update" id="Update" class="btn btn-primary" onclick="return editT();">   <input type="button" name="delete" value="Delete" id="Delete" class="btn btn-danger" onclick="return deleteT();"></center>

                                </div>                                
                            </form>           
                        </div>
                        <!-- /.box-body -->     
                    </div>
                    <!-- /.box 
                </section>
                    <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->

            <footer class="main-footer">

                <strong><a href="http://www.github.com/only1ryu">Rakesh Sahani</a></strong> 
            </footer>

        </div>
        <!-- ./wrapper -->

        <!-- jQuery 2.2.0 -->
        <script src="plugins/jQuery/jQuery-2.2.0.min.js"></script>
        <!-- Bootstrap 3.3.6 -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <!-- SlimScroll -->
        <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
        <!-- FastClick -->
        <script src="plugins/fastclick/fastclick.js"></script>
        <!-- AdminLTE App -->
        <script src="dist/js/app.min.js"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="dist/js/demo.js"></script>
    </body>
</html>
