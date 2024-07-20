module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count1, count2;

// Partition the 3-bit input into two 2-bit sub-vectors
assign count1 = {1'b0, in[2:1]};
assign count2 = {in[0], 1'b0};

// Instantiate two 2-bit population count circuits
popcount2 pc1 (.in(count1), .out(out[0]));
popcount2 pc2 (.in(count2), .out(out[1]));

endmodule
module popcount2 (
    input [1:0] in,
    output [0:0] out
);

// 2-bit population count logic
assign out[0] = in[1] + in[0];

endmodule
