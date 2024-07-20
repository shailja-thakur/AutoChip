module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            // Set the don't-care entries to 1 where convenient (12)
            // 00: d -> 1, 0, d -> 1, d -> 1
            // 01: 0, d -> 0, 1, 0
            // 11: 1, 1, d -> 0, d -> 0
            // 10: 1, 1, 0, d -> 0
            4'b0011, // d -> 1 (i.e., 0011 sets f to 1)
            4'b1110, 
            4'b1111, // d -> 1 (i.e., 1110 and 1111 set f to 1)
            4'b1011, 4'b1010, // d and 0 pts to f to 0
            4'b0110, 4'b0111,  // d -> 0, i.e., 0110~0111 matches d to 0
            4'b1000, 4'b1100, 4'b1101: f = 1'b1; // f =1
            default: f = 1'b0; // For 0001, 0000, 0010, 0100, 0101, matching d to actual 0 value
        endcase
    end

endmodule
