module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count_1;
wire [1:0] count_2;

// First stage of population count
assign count_1[0] = in[0] | in[1];
assign count_1[1] = in[0] & in[1];

// Second stage of population count
assign count_2[0] = count_1[0] | in[2];
assign count_2[1] = count_1[1] | (count_1[0] & in[2]);

// Final output
assign out = count_2;

endmodule
