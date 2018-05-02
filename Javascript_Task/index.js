class Item {
    constructor(content,iscompleted)
    {
        this.content=content;
        this.iscompleted=iscompleted;
    }
}
$(document).ready(function(){
    load();
})

$(document).ready(function(){

    $("#Add").click(function(){
        
        let input_value=$("#input");
        if(input_value.val()==='')
        {
            alert('task can not be blank');
            return
        }
        let content=`
        <div id="my-card" class="task mdc-card mdc-card__primary-action mdc-ripple-surface" href="#" style="--mdc-ripple-fg-size:128.4px; --mdc-ripple-fg-scale:2.15888; --mdc-ripple-fg-translate-start:114.8px, 54.925px; --mdc-ripple-fg-translate-end:42.8px, 15.8px;">
                <h3 class="mdc-typography" mdc-typography--display2>${input_value.val()}</h3>
               
        
        </div>
        `
       
        let task_div=$("#tasks");
        setlocal(input_value.val(),false);
        load();

    })



});


function load()
{
    

    let task_div=$("#tasks");
    $("#tasks").empty();
    var values = [],
        keys = Object.keys(localStorage),
        i = keys.length;

    for(i=0;i<keys.length;i++) {
        values.push( JSON.parse(localStorage.getItem(keys[i])) );
    }

    values.forEach((element,index)=>{
        let content=`

        <span id="${index+1}" class="mdc-card task mdc-card__primary-action mdc-ripple-surface" href="#" style="--mdc-ripple-fg-size:128.4px; --mdc-ripple-fg-scale:2.15888; --mdc-ripple-fg-translate-start:114.8px, 54.925px; --mdc-ripple-fg-translate-end:42.8px, 15.8px;">
        <div class="mdc-form-field">
        <div class="mdc-checkbox">
          <input type="checkbox"
                 id="my-checkbox"
                 class="mdc-checkbox__native-control"/>
          <div class="mdc-checkbox__background">
            <svg class="mdc-checkbox__checkmark"
                 viewBox="0 0 24 24">
              <path class="mdc-checkbox__checkmark-path"
                    fill="none"
                    stroke="white"
                    d="M1.73,12.91 8.1,19.28 22.79,4.59"/>
            </svg>
            <div class="mdc-checkbox__mixedmark"></div>
          </div>
        </div>
       
      </span>
        <h3  class="mdc-typography" mdc-typography--display2>
        
        ${element.content}</h3>
        <span class="delete_button" style="position: absolute; right: 0; top: 0;  padding: 12px 16px 12px 16px;">  <i style="text-align:right" class="material-icons">delete</i> </span>

               
        
        </div>
        `;
        task_div.append(content);
      
      if(element.iscompleted===true)
      {  
         task_div.children().addClass('checked');
         task_div.children().children().children().children().prop('checked',true);

      }
   
    });

}
function setlocal(value,iscompleted)
{
    if (typeof(Storage) !== "undefined") {
        keys = Object.keys(localStorage),
        new_key = keys.length+1;

        localStorage.setItem(new_key, JSON.stringify(new Item(value,iscompleted)));

    } else {
        alert("your browser does'nt support local storage please update your browser ")
    }
}
function getlocal(key)
{
    if (typeof(Storage) !== "undefined") {
       return  localStorage.getItem(key);

    } else {
        alert("your browser does'nt support local storage please update your browser ")
        return
    }
}
function deleteLocal(key)
{
    localStorage.removeItem(key);
}
function setcompleted(key)
{
  let item=JSON.parse(getlocal(key));
  console.log(item);
  deleteLocal(key);
  item.iscompleted=true;
  localStorage.setItem(key,JSON.stringify(item));
    

}

function setUncompleted(key)
{
  let item=JSON.parse(getlocal(key));
  console.log(item);
  deleteLocal(key);
  item.iscompleted=false;
  localStorage.setItem(key,JSON.stringify(item));
    

}
$(document).on('click', '.task', function(){
    checkbox=  $(this).children().children().children();
    if(checkbox.is(':checked'))
    {
        $(this).removeClass("checked");
        checkbox.prop('checked', false);
        setUncompleted($(this).attr('id'));
        
    }
    else{
    $(this).addClass("checked");
   checkbox.prop('checked', true);
   
   
  setcompleted($(this).attr('id'));
   
  
    }

  });

  $(document).on('click', '.delete_button', function(){
    
      parentele=$(this).parent().parent().attr('id');
      console.log("id recieved"+parentele);


    deleteLocal(parentele);
    $(this).parent().parent().remove(); 

  });

