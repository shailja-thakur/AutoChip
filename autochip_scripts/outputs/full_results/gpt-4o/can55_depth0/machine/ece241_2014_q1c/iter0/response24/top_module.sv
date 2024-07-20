module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [7:0] sum;
    wire msb_a, msb_b, msb_sum;

    assign sum = a + b;
    assign s = sum;
    
    assign msb_a = a[7];
    assign msb_b = b[7];
    assign msb_sum = sum[7];
    
    assign overflow = (msb_a == msb_b) && (msb_sum != msb_a);

endmodule
