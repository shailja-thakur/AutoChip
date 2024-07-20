module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(a or b or c or d)
begin
    case ({a, b, c, d})  // Use 4-bit vector to select case
        4'b0000: out = 1'b0;  // if a, b, c, and d are all 0, then out is 0
        4'b1111: out = 1'b1;  // if a, b, c, and d are all 1, then out is 1
        default: out = 1'b0;  // Otherwise, out is 0
    endcase
end

endmodule
