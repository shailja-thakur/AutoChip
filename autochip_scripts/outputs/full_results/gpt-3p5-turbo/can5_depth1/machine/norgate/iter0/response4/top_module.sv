module top_module(
    input a, 
    input b,
    output out
);

// OR gate
wire or_gate;
assign or_gate = a | b;

// inverter
assign out = ~or_gate;

endmodule
