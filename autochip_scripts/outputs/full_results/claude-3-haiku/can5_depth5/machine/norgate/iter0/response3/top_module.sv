module top_module(
    input a, 
    input b,
    output out
);

    // Implement the logic for the OR gate and the inverter
    wire or_gate_output;
    assign or_gate_output = a | b;
    assign out = ~or_gate_output;

endmodule
