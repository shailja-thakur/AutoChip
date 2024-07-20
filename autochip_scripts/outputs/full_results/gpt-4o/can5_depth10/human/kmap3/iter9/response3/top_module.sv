module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    out = (~c & ~d) | (~a & ~b & d) | (~a & c & ~d) | (a & b & c & ~d);
end

endmodule
