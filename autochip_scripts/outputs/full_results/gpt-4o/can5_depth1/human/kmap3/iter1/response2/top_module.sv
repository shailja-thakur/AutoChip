module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    // Karnaugh map simplified expression: out = c'd + a'cd + abc + abd
    out = (~c & d) | (~a & c & d) | (a & b & c) | (a & b & d);
end

endmodule
