module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Add the two numbers
wire [8:0] sum;
assign sum = {1'b0, a} + {1'b0, b};

// Compute the output
assign s = sum[7:0];

// Detect overflow
assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
