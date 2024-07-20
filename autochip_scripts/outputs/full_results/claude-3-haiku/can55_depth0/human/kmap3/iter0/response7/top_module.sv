module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        4'b00: out = a;
        4'b01: out = 1'b0;
        4'b11: out = 1'b1;
        4'b10: out = 1'b1;
        default: out = b;
    endcase
end

endmodule
