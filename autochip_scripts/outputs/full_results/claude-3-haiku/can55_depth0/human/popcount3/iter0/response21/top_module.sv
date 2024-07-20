module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count;

// Instantiate a 3-bit population count circuit
popcount3 popcount_inst (
    .in(in),
    .out(count)
);

// Assign the output
assign out = count;

endmodule
module popcount3 (
    input [2:0] in,
    output [1:0] out
);

assign out = in[0] + in[1] + in[2];

endmodule
