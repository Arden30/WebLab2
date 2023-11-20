let X, Y, R;
document.addEventListener("DOMContentLoaded", function (){
    document.getElementById("y").addEventListener("input", checkY)
    document.getElementById("submit-button").addEventListener("click", submit)
    document.getElementById("clear-button").addEventListener("click", clear);
    document.getElementById("coordinates").addEventListener("mousedown", graph)
});

const checkY = function (){
    Y = document.getElementById("y");
    if (Y.value.trim() === "") {
        Y.setCustomValidity("Input number!");
        return false;
    } else if (!isFinite(Y.value.replace(",", "."))){
        Y.setCustomValidity("Wrong input (only number)!");
        return false;
    } else if (Y.value.replace(",", ".") >= 3 || Y.value.replace(",", ".") <= -5){
        Y.setCustomValidity("Input number in (-5; 3)!");
        return false;
    } else {
        Y.setCustomValidity("");
        return true;
    }
}

const send = function (X, Y, R) {
    $.ajax({
        type: 'POST',
        url: 'controller',
        data: {
            'x': X,
            'y': Y,
            'r': R
        },
        success: function () {
            window.location.href = 'index.jsp';
        },
        error: function () {
            alert("Error");
        }
    });
}

const submit = function(e) {
    if (!checkY()) return;
    e.preventDefault();
    X = (new FormData(document.getElementById("coordinates-form"))).get("x");
    R = (new FormData(document.getElementById("coordinates-form"))).get("r");

    if (R == null) {
        alert("Choose R!")
        return;
    }
    e.preventDefault();

    send(X, Y.value.replace(",", "."), R);
}

const graph = function (e) {
    R = (new FormData(document.getElementById("coordinates-form"))).get("r");
    if (R) {
        let svgSize = 410;

        const position = $('svg').offset();
        const rowX = e.pageX - position.left;
        const rowY = e.pageY - position.top;

        const x = ((-1 * (R / 75) * (svgSize / 2 - rowX)) / 2 - 10 * R / 75).toFixed(2);
        const y = (((R / 75) * (svgSize / 2 - rowY)) / 2 + 10 * R / 75).toFixed(2);

        if (x < -4 || x > 4) {
            alert('Choose x in [-4;4]');
        } else if (y <= -5 || y >= 3) {
            alert('Choose y in (-5;3)');
        }
        send(x, y, R);
    } else {
        alert('Choose R!');
    }
}

const clear = function () {
    $.ajax({
        type: 'POST',
        url: 'controller',
        data: {'clear': true},
        success: function () {
            window.location.href = 'index.jsp';
        },
        error: function () {
            alert("Error");
        }
    });
}