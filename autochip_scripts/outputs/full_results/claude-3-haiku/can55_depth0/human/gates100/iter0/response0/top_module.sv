module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] in_not;
assign in_not = ~in;

// 100-input AND gate
assign out_and = &in;

// 100-input OR gate
assign out_or = |in;

// 100-input XOR gate
assign out_xor = ^in;

endmodule
