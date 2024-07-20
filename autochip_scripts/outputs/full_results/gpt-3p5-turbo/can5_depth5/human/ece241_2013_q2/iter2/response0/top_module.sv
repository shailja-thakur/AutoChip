module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

    always @* begin
        // SOP form expressions for the output
        case ({a, b, c, d})
            4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110,
            4'b1001, 4'b1010, 4'b1101, 4'b1110:
                out_sop = 1'b0;
            4'b0010, 4'b0111, 4'b1111:
                out_sop = 1'b1;
            default:
                out_sop = 1'bx; // Use don't-care value for undefined inputs
        endcase

        // POS form expressions for the output
        case ({a, b, c, d})
            4'b0000: out_pos = 1'b0;
            4'b0001: out_pos = 1'b0;
            4'b0010: out_pos = 1'b1;
            4'b0100: out_pos = 1'b0;
            4'b0101: out_pos = 1'b0;
            4'b0110: out_pos = 1'b0;
            4'b0111: out_pos = 1'b1;
            4'b1001: out_pos = 1'b0;
            4'b1010: out_pos = 1'b0;
            4'b1101: out_pos = 1'b0;
            4'b1110: out_pos = 1'b0;
            4'b1111: out_pos = 1'b1;
            default: out_pos = 1'bx; // Use don't-care value for undefined inputs
        endcase
    end
endmodule
