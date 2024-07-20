module top_module (
    input a,
    input b,
    input sel,
    output out
);
    /* Define internal wires */
    wire mux_out;

    /* Instantiate the multiplexer */
    mux u1 (
        .a(a),
        .b(b),
        .sel(sel),
        .out(mux_out)
    );

    /* Assign the output of the multiplexer to the 'out' output port */
    assign out = mux_out;

    /* Define a multiplexer module */
    module mux (
        input a,
        input b,
        input sel,
        output out
    );
        /* Use a ternary operator to select the output value */
        assign out = (sel == 1'b1) ? b : a;
    endmodule
