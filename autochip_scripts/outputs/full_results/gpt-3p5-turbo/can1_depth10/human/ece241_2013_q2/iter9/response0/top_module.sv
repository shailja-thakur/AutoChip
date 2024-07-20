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
        // Default case for out_sop = 0 when input condition does not match any other cases
        default: out_sop = 0;
    endcase
end

always @(*)
begin
    case ({a, b, c, d})
        // Matches for out_pos = 1
        4'b0010, 4'b0111, 4'b1111: out_pos = 1;
        // Matches for out_pos = 0
        4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110: out_pos = 0;
        // Default case for out_pos = 1 when input condition does not match any other cases
        default: out_pos = 1;
    endcase
end

endmodule
