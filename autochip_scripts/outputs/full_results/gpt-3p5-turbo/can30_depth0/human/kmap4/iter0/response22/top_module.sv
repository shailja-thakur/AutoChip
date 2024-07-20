module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);
    
    always @* begin
        case ({a, b, c, d})
            4'b0000, 4'b0011, 4'b0111, 4'b1110: out = 0;
            4'b0100, 4'b1001, 4'b1101, 4'b1010: out = 1;
            default: out = 0;
        endcase
    end
endmodule
