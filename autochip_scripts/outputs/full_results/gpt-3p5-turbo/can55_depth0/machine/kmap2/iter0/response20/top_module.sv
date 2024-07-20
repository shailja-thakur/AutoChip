module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(a or b or c or d) begin
    if ((c == 0 && b == 0) || (d == 0 && a == 0) || (a && c && d) || (b && c && d))
        out <= 1;
    else
        out <= 0;
end

endmodule
