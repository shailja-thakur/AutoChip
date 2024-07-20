module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d})
        2'b00: out = a;
        2'b01: out = 0;
        2'b11, 2'b10: out = 1;
        default: out = 1; // Handling the don't-care condition
    endcase
end

endmodule
