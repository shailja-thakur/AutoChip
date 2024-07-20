module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count1, count2;

// First level of logic
assign count1[0] = in[0] ^ in[1];
assign count1[1] = in[0] & in[1];

// Second level of logic
assign count2[0] = count1[0] ^ in[2];
assign count2[1] = count1[1] | in[2];

// Output
assign out = count2;

endmodule
