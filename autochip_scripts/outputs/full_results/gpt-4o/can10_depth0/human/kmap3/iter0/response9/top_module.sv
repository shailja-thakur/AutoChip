module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0001, 4'b0011, 4'b0111, 4'b1010, 4'b1011, 4'b1101, 4'b1110, 4'b1111: out = 1;
        4'b0010, 4'b0110, 4'b1000, 4'b1001: out = 1;  // d-don't-cares chosen as 1 for simplicity
        default: out = 0;
    endcase
end

endmodule
