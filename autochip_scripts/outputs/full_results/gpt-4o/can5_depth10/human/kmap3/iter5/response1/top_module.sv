module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    out = (a & b & c) | (a & !c & !d) | (!a & b & d);
end

endmodule
