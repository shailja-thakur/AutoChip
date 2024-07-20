module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @* begin
        case({a, b, c, d})
            4'b0000, 4'bxxxx: out = 1'b0;  // Updated case statement to include both 0000 and unknown (xxxx) inputs
            default: out = 1'b1;
        endcase
    end
endmodule
