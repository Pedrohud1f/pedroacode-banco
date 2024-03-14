var app = new Vue({
    el: '#app',
    data: {
        titulo: "Dashboard",
        banco_aberto: false,
        nome_completo: "" ,
        id_user: 0,
        valor_banco: 0,
        depositar: 0,
        sacar: 0,
        salarios: [],
        css_altura: 0,
        css_altura_corpo: 0
    }
})

function menu(titulo) {
    app.titulo = titulo
}


document.addEventListener("DOMContentLoaded", function() {

	window.addEventListener("message", function (event) {
        var data = event.data
        if(data.open) {
            app.banco_aberto = true
            app.nome_completo = data.nome_completo
            app.id_user = data.id_User
            app.valor_banco = data.saldo
            app.salarios = data.salarios
        }
    })

    document.onkeyup = function(data) {
         if (data.which == 27){
             sair()
         }
    }

})

function sair() {
    app.banco_aberto = false
    $.post("http://bank_one/fechar");
}


function somenteNumeros(num) {
    var er = /[^0-9.]/;
    er.lastIndex = 0;
    var campo = num;
    if (er.test(campo.value)) {
      campo.value = "";
    }
}

function depositar() {
    $.post("http://bank_one/depositar", JSON.stringify({ valor : app.depositar}), function(data) { 
        console.log("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")
        console.log(data.status)
        console.log("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")
        app.depositar = 0
    });
}

function sacar() {
    $.post("http://bank_one/sacar", JSON.stringify({ valor : app.sacar}), function(data) { 
        console.log("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")
        console.log(data.status)
        console.log("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")
        app.sacar = 0
    });
}

function sacarSalario(salario) {
    $.post("http://bank_one/receberSalario", JSON.stringify(salario), function(data) { 
        console.log("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")
        console.log(data.status)
        console.log("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")

        app.salarios = data.salarios

    });
}

$(document).ready(function () { 
    var div_height = $(".corpo").height();

    console.log("++++++++++++++++++++++++++++++++++++++++++++++")
    console.log(div_height)
    console.log("++++++++++++++++++++++++++++++++++++++++++++++")

    let resltado_altura = div_height - 60

    app.css_altura = "height: " +  div_height + "px;"
    app.css_altura_corpo = "height: " +  resltado_altura + "px;"
});