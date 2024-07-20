module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @* begin
        case({a, b, c, d})
            4'b0000: out = 1'b0; 
            default: out = 1'b0; // Changed the default case to 0
        endcase
    end
endmodule
