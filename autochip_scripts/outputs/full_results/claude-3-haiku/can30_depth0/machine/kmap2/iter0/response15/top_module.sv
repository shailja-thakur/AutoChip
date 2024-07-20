module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    out = ((~c & ~b) | (~d & ~a) | (a & c & d) | (b & c & d));
end

endmodule
