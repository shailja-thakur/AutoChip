module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @* begin
        case({a, b, c, d})
            4'b0000, 4'b0001, 4'b0010, 4'b1100: out = 1'b0;  // changed 4'b0011 to 4'b1100
            default: out = 1'b1;  // reversed the outputs for default case
        endcase
    end
endmodule
