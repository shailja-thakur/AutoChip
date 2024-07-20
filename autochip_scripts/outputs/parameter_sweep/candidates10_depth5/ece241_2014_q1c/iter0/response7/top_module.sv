module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

reg [8:0] sum;


always @(*) begin
    sum = $signed(a) + $signed(b);
    s = sum[7:0];
    overflow = sum[8];
end

endmodule
