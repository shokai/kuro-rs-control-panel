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
    }
)
