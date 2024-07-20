module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count1;
wire [1:0] count2;

// Count the number of 1's in the lower 2 bits
assign count1 = (in[0] ? 1'b1 : 1'b0) + (in[1] ? 1'b1 : 1'b0);

// Count the number of 1's in the upper bit
assign count2 = in[2] ? 1'b1 : 1'b0;

// Combine the counts for the final output
assign out = count1 + count2;

endmodule
