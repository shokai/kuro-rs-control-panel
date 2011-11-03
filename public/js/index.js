$(
    function(){
        $('#btn_add_ir').click(
            function(e){
                var name = $('#input_ir_name').val().
                    replace(/^\//,'').replace(/\/$/,'').
                    replace(ir_name_regexp,'');
                location.href = app_root+'/ir/'+name;
            }
        );
        $('#irs input.button_fire').click(
            function(e){
                var name = e.currentTarget.name;
                $.ajax(
                    {
                        url : app_root+'/kuro-rs.json',
                        data : {
                            name : name
                        },
                        success : function(e){
                            alert(e.msg);
                        },
                        error : function(e){
                            alert(e.err);
                        },
                        complete : function(e){
                        },
                        type : 'POST',
                        dataType : 'json'
                    }
                );
            }
        );
    }
)
