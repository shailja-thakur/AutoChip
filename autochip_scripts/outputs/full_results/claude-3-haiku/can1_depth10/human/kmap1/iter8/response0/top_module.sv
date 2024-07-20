module top_module(
    input a, 
    input b,
    input c,
    output reg out
);

always @(*) begin
    out = (b & ~c) | (a & b);
end

endmodule
