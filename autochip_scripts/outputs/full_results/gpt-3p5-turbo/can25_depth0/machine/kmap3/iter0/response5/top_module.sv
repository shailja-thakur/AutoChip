module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);
    always @*
    begin
        case ({a, b, c, d})
            4'b0000: out = 1'b0;
            4'b0001: out = 1'b0;
            4'b0011: out = 1'b1;
            4'b0010: out = 1'b1;
            4'b0100: out = 1'bx;
            4'b0101: out = 1'b0;
            4'b0111: out = 1'b0;
            4'b0110: out = 1'b0;
            4'bc: out = 1'b1;
            4'bd: out = 1'bx;
            4'bf: out = 1'b1;
            4'be: out = 1'b1;
            4'b1000: out = 1'b1;
            4'b1001: out = 1'bx;
            4'bb: out = 1'b1;
            4'ba: out = 1'b1;
            default: out = 0;
        endcase
    end
endmodule
