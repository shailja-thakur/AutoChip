module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

// Internal wire declarations
wire and_result;
wire or_result;
wire xor_result;

// AND gate
assign and_result = &in;

// OR gate
assign or_result = |in;

// XOR gate
assign xor_result = ^in;

// Output assignments
assign out_and = and_result;
assign out_or = or_result;
assign out_xor = xor_result;

endmodule
