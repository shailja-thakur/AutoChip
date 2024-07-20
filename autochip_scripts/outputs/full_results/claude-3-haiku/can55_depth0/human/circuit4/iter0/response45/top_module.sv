module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg q
);

always @(*) begin
    q = ((a & ~b & ~c) | (~a & b & ~c) | (~a & ~b & c) | (a & b & c)) & d;
end

endmodule
