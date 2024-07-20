module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({a, b, c, d})
        4'b0000: out = 0;
        4'b1111: out = 1;
        4'b0101: out = 0;
        default: out = 0; // default case for all other combinations
    endcase
end

endmodule
