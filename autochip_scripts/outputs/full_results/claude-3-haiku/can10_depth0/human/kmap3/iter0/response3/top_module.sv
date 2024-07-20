module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        4'b00_01, 4'b00_11, 4'b01_11, 4'b10_11, 4'b10_01: out = 1'b1;
        4'b00_00, 4'b01_00, 4'b01_01, 4'b10_00, 4'b10_10: out = 1'b0;
        4'b01_10, 4'b11_00, 4'b11_01, 4'b11_10, 4'b11_11: out = a & b;
    endcase
end

endmodule
