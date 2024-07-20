module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

reg [8:0] temp_sum;

always @(*) begin
    temp_sum = $signed(a) + $signed(b);
    s = temp_sum[7:0];
    overflow = temp_sum[8] ^ temp_sum[7];
end

endmodule
