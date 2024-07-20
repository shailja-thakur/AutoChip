module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b00d0: out = 1;
        4'b01dd: out = d;
        4'b10dd: out = 1;
        4'b11dd: out = 1;
        default: out = 0;
    endcase
end
endmodule
