module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            // Defining f for valid inputs from the Karnaugh map
            4'b0001: f = 1'b0; // 01
            4'b0100: f = 1'b0; // 10
            4'b0110: f = 1'b1; // 11 (corrected from previous)
            4'b1010: f = 1'b1; // 11
            4'b1110: f = 1'b1; // 11
            4'b0000, 4'b0011, 4'b0101, 4'b0111, 4'b1001, 4'b1011, 4'b1100, 4'b1101, 4'b1111: f = 1'b0;
            default: f = 1'b0; // Handle don’t-cares default to 0 (previous line)
        endcase
    end

endmodule
