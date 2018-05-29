<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Invoice</title>
    <link rel="stylesheet" href="{{ asset('css/invoice.css') }}" media="all" />
    <link rel="shortcut icon" type="image/png" href="/icon/favicon.png" />
</head>
<body>
<header class="clearfix">
    <div id="logo">
        <img style="width: 70px; height: 70px;" src="{{ asset('icon/favicon.png') }}">
    </div>
    <div id="company">
        <h2 class="name">RE:Event, SA</h2>
        <div>R. Dr. Roberto Frias, 4200-465 Porto, PT</div>
        <div>(602) 519-0450</div>
        <div><a href="mailto:company@example.com">admin@reevent.com</a></div>
    </div>
    </div>
</header>
<main>
    <div id="details" class="clearfix">
        <div id="client">
            <div class="to">INVOICE TO:</div>
            <h2 class="name">{{$invoice->name}}</h2>
            <div class="address">{{$invoice->address}}</div>
        </div>
        <div id="invoice">
            <h1>INVOICE #{{$invoice->idinvoice}}</h1>
            <div class="date">Date of Invoice: {{$invoice->date}}</div>
        </div>
    </div>
    <table border="0" cellspacing="0" cellpadding="0">
        <thead>
        <tr>
            <th class="no">#</th>
            <th class="desc">DESCRIPTION</th>
            <th class="unit">UNIT PRICE</th>
            <th class="qty">QUANTITY</th>
            <th class="total">TOTAL</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="no">01</td>
            <td class="desc"><h3>{{$query->name}}</h3>{{$query->description}}</td>
            <td class="unit">EUR {{money_format("%i", round((($invoice->amount / $invoice->quantity)*0.75), 2))}}</td>
            <td class="qty">{{$invoice->quantity}}</td>
            <td class="total">EUR {{ money_format("%i",round($invoice->amount * 0.75,2))}}</td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="2"></td>
            <td colspan="2">SUBTOTAL</td>
            <td>EUR {{money_format("%i",round($invoice->amount * 0.75,2))}}</td>
        </tr>
        <tr>
            <td colspan="2"></td>
            <td colspan="2">TAX 25%</td>
            <td>EUR {{money_format("%i",round($invoice->amount * 0.25,2))}}</td>
        </tr>
        <tr>
            <td colspan="2"></td>
            <td colspan="2">GRAND TOTAL</td>
            <td>EUR {{money_format("%i",round($invoice->amount,2))}}</td>
        </tr>
        </tfoot>
    </table>
    <div id="thanks">Thank you!</div>
    <div id="notices">
        <div>NOTICE:</div>
        <div class="notice">A finance charge of 1.5% will be made on unpaid balances after 30 days.</div>
    </div>
</main>
<footer>
    Invoice was created on a computer and is valid without the signature and seal.
</footer>
</body>
</html>