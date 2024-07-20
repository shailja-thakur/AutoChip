module top_module(
    input [3:0] y,   // corrected input range from [3:1] to [3:0]
    input w,
    output reg Y2);

    always_comb
    begin
        case({y, w})   // corrected concatenation of input signals
            4'h0: Y2 = 1'b0;   // corrected output values according to the specification
            4'h1: Y2 = 1'b0;
            4'h2: Y2 = 1'b1;
            4'h3: Y2 = 1'b1;
            4'h4: Y2 = 1'b0;
            4'h5: Y2 = 1'b1;
            4'h6: Y2 = 1'b0;
            4'h7: Y2 = 1'b0;
            4'h8: Y2 = 1'b0;
            4'h9: Y2 = 1'b1;
            4'ha: Y2 = 1'b1;
            4'hb: Y2 = 1'b1;
            default: Y2 = 1'b0;   // added default case to handle invalid inputs
        endcase
    end

endmodule
