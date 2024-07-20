module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c,d,a,b})
        4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b0111: out = 0;
        4'b0010, 4'b0011, 4'b1001, 4'b1010, 4'b1011, 4'b1101, 4'b1110, 4'b1111: out = 1;
        default: out = 1; // Handling don't-care conditions conveniently as '1'
    endcase
end

endmodule
