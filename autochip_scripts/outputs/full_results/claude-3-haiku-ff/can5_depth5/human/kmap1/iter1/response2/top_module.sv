module top_module(
    input a,
    input b,
    input c,
    output reg out
);

always @(*) begin
    case ({a, b, c})
        3'b000: out = 0;
        3'b001: out = 1;
        3'b010: out = 1;
        3'b011: out = 1;
        3'b100: out = 1;
        3'b101: out = 1;
        3'b110: out = 1;
        3'b111: out = 1;
    endcase
end

endmodule
