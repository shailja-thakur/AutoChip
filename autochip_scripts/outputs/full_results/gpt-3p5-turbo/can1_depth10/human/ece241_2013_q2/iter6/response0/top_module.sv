module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

always @(*)
begin
    case ({a, b, c, d})
        // Matches for out_sop = 1
        4'b0010, 4'b0111, 4'b1111: out_sop = 1;
        // Matches for out_sop = 0
        4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110: out_sop = 0;
        // Matches for out_sop = X (don't-care)
        4'b0011, 4'b0101, 4'b1011, 4'b1110: out_sop = X;
        default: out_sop = 0;
    endcase
end

always @(*)
begin
    case ({a, b, c, d})
        // Matches for out_pos = 1
        4'b0010: out_pos = 1;
        4'b0111: out_pos = 1;
        4'b1111: out_pos = 1;
        // Matches for out_pos = 0
        4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101: out_pos = 0;
        // Matches for out_pos = X (don't-care)
        4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b1000, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111: out_pos = X;
        default: out_pos = 0;
    endcase
end

endmodule
