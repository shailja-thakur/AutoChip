module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        2'b00: out = b;
        2'b01, 2'b10, 2'b11: out = 1'b1;
        default: out = 1'b1; // Treat don't-care as 1
    endcase
end

endmodule
