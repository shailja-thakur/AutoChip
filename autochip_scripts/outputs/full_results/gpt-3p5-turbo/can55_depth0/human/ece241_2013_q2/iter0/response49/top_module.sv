module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    reg out_sop;
    reg out_pos;

    always @* begin
        // S1 = 0, S2 = 1, S3 = 2, S4 = 3, S5 = 4, S6 = 5, S7 = 6, S8 = 7, S9 = 8, S10 = 9, S11 = 10, S12 = 11, S13 = 12, S14 = 13, S15 = 14
        case ({a, b, c, d})
            4'b0010, 4'b0111, 4'b1111: out_sop = 1;
            4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110: out_sop = 0;
            default: out_sop = 0;
        endcase
    end

    always @* begin
        // S1 = 0, S2 = 1, S3 = 2, S4 = 3, S5 = 4, S6 = 5, S7 = 6, S8 = 7, S9 = 8, S10 = 9, S11 = 10, S12 = 11, S13 = 12, S14 = 13, S15 = 14
        case ({a, b, c, d})
            4'b0010, 4'b0111, 4'b1111: out_pos = 1;
            4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110: out_pos = 0;
            default: out_pos = 1;
        endcase
    end

endmodule
