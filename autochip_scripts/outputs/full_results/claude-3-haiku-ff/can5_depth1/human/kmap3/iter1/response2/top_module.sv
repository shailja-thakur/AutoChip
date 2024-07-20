module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        2'b00: out = a; // a
        2'b01: out = 1'b0; // 0
        2'b11: out = 1'b1; // 1 
        2'b10: out = 1'b1; // 1
    endcase
end

endmodule
