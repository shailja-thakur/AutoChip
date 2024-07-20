module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] in_not;
wire and_out;
wire or_out;
wire xor_out;

// complement of the input
assign in_not = ~in;

// AND gate
assign out_and = and(out_and, in);
assign out_and = ~out_and;

// OR gate
assign out_or = or(out_or, in);
assign out_or = ~out_or;

// XOR gate
assign out_xor = xor(out_xor, in);
assign out_xor = ~out_xor;

endmodule
