module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

reg [8:0] sum;

always @(*) begin
    sum = a + b;
    overflow = (sum[8] == 1);
    s = sum[7:0];
end

endmodule
