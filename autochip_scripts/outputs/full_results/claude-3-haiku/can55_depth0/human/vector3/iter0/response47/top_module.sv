module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

// Concatenate the input vectors
wire [29:0] concat_inputs = {a, b, c, d, e, f};

// Split the concatenated input into the output vectors
assign w = {concat_inputs[29:24], 2'b11};
assign x = {concat_inputs[23:18], 2'b11};
assign y = {concat_inputs[17:12], 2'b11};
assign z = {concat_inputs[11:6], 2'b11};

endmodule
