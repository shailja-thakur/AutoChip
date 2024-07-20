module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count1, count2;

// Split the 3-bit input into two 2-bit halves
assign count1 = {1'b0, in[2]} + {1'b0, in[1]} + {1'b0, in[0]};
assign count2 = {1'b0, in[2]} + {1'b0, in[1]} + {1'b0, in[0]};

// Add the counts of the two halves
assign out = count1 + count2;

endmodule
