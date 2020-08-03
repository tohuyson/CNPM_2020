function recalculateTotal(sc) {
    var total = 0;
    sc.find('selected').each(function () {
        total += this.data().price;
//                    console.log(this.data().price)
    });
    return total;
}

function reSetBookingTicket(sc) {
    var booking_seats = "";
    sc.find('selected').each(function () {
        booking_seats += this.settings.label + ",";
    });
    return booking_seats;
}

function controlButton() {
    if ($("input[name='tabs']").val() == 1) {
        $(".btn-next").show();
        $(".btn-previous").hide();
        $(".btn-booking").hide();
    } else {
        $(".btn-previous").show();
        $(".btn-next").hide();
        $(".btn-booking").show();
    }
}

function next() {
    if($("input[name='booking_seats']").val() == "")
        alert("Not choose seat");
    else {
        $("#booking").hide(400);
        $("input[name='tabs']").val(2);
        controlButton();
        $("#product").show(200);
        return false;
    }
}

function previous() {
    $("#product").hide(400);
    $("input[name='tabs']").val(1);
    controlButton();
    $("#booking").show(200);
    return false;
}

$(".buttondau").on("click", function() {

    var $button = $(this);
    var oldValue = $button.parent().find("input").val();

    if ($button.attr("name") === "plus") {
        var newVal = parseFloat(oldValue) + 1;
    } else {
        // Don't allow decrementing below zero
        if (oldValue > 0) {
            var newVal = parseFloat(oldValue) - 1;
        } else {
            newVal = 0;
        }
    }
    $button.parent().find("input").val(newVal);
    updateProductPrice();
});

$("input[name='product']").change(function () {
    updateProductPrice();
});

function updateProductPrice() {
    var total = 0;
    var list_product = "";
    product = document.getElementsByName("product");
    for (i = 0; i < product.length; i++) {
        var qty = product[i].value;
        total += (qty*product[i].dataset.price);
        if (qty != 0) {
            list_product += product[i].dataset.id + "_" + qty + ",";
        }
    }
    $("input[name='list_product']").val(list_product);
    console.log(list_product);
    $(".info-invoice .price-product span").text(total + " VND");
    $("input[name='input_price_product']").val(total);
    updateTotal();
}

function updateTotal() {
    var ticket = $("input[name='input_price_ticket']").val();
    var product = $("input[name='input_price_product']").val();
    var total = parseInt(ticket) + parseInt(product);
    $(".info-invoice .total span").text((parseInt(ticket) + parseInt(product)) + " VND");
    console.log(total);
}