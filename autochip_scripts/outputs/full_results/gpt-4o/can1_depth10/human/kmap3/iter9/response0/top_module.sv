module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    out = (!c && d) || (c && (a || !b));
end

endmodule
