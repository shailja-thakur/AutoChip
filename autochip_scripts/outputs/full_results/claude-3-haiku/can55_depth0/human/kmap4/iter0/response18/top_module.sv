module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({a, b, c, d})
        4'b0001: out = 1;
        4'b0011: out = 1;
        4'b0101: out = 1;
        4'b0111: out = 1;
        4'b1001: out = 1;
        4'b1011: out = 1;
        default: out = 0;
    endcase
end

endmodule
