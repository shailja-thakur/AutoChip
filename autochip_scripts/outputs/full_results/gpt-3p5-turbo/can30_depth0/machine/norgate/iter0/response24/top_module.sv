module top_module(
    input a,
    input b,
    output out
);

    // OR gate
    wire or_gate_out;
    or_gate or1(a, b, or_gate_out);

    // Inverter
    wire inverter_out;
    inverter inv1(or_gate_out, inverter_out);

    // Assign output
    assign out = inverter_out;

endmodule
module or_gate(
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule
module inverter(
    input inp,
    output out
);
    assign out = ~inp;
endmodule
