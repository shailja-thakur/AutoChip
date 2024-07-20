module top_module(
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);

// Assign the outv output to be the same as the vec input
assign outv = vec;

// Assign the o2 output to be the most significant bit of the vec input
assign o2 = vec[2];

// Assign the o1 output to be the middle bit of the vec input
assign o1 = vec[1];

// Assign the o0 output to be the least significant bit of the vec input
assign o0 = vec[0];

endmodule
