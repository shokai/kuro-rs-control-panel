$(
    function(){
        if(ir.data && ir.data.length > 0){
            display_ir_data(ir.data);
        }
        else{
            $('div#operate').hide();
            $('textarea').attr('disabled', true);    
        }
        $('#btn_read').click(kuro_rs.read);
        $('#btn_write').click(kuro_rs.write);
        $('#btn_save').click(kuro_rs.save);
    }
);

var display_ir_data = function(data){
    $('#data').html(data);
    $('#api_name').html('curl -d "name='+ir.name+'" '+app_root+'/kuro-rs.json');
    $('#api_data').html('curl -d "data='+data+'" '+app_root+'/kuro-rs.json');
    var api_url = location.href+'.json';
    $('.api #get').html($('<a>').attr('href', api_url).html(api_url));
};

var kuro_rs = {};
kuro_rs.read = function(){
    $('#btn_read').attr('disabled', true);
    $.ajax(
        {
            url : app_root+'/kuro-rs.json',
            success : function(e){
                display_ir_data(e.data);
                $('div#operate').show();
            },
            error : function(e){
                alert(e.err);
            },
            complete : function(e){
                $('#btn_read').attr('disabled', false);
            },
            type : 'GET',
            dataType : 'json'
        }
    );
};

kuro_rs.write = function(){
    $('#btn_write').attr('disabled', true);
    $.ajax(
        {
            url : app_root+'/kuro-rs.json',
            data : {
                data : $('textarea#data').val()
            },
            success : function(e){
                alert(e.msg);
            },
            error : function(e){
                alert(e.err);
            },
            complete : function(e){
                $('#btn_write').attr('disabled', false);
            },
            type : 'POST',
            dataType : 'json'
        }
    );
};

kuro_rs.save = function(){
    $('#btn_save').attr('disabled', true);
    var data = $('textarea#data').val();
    $.ajax(
        {
            url : location.href+'.json',
            data : {
                data : data
            },
            success : function(e){
                ir = e;
                alert("saved!");
            },
            error : function(e){
                alert(e.err);
            },
            complete : function(e){
                $('#btn_save').attr('disabled', false);
            },
            type : 'POST',
            dataType : 'json'
            
        }
    );
};