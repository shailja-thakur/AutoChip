module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @* begin
    case ({a, b, c, d}) 
        4'b0000: out = 1'b0; // If a, b, c, and d are all 0, then the output out is 0.
        4'b1111: out = 1'b1; // If a, b, c, and d are all 1, then the output out is 1.
        default: out = 1'b0; // Otherwise, the output out is 0.
    endcase
end

endmodule
