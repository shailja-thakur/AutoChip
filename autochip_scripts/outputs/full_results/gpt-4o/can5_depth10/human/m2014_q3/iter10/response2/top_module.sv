module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            // Define the outputs based on given Karnaugh map and corrections
            4'b0001, 4'b0010, 4'b0011, 4'b0111, 4'b1000, 4'b1001, 4'b1100, 4'b1111: f = 1'b1; // Specified 1s
            4'b0000, 4'b0010, 4'b0100, 4'b0101, 4'b0101, 4'b0110, 4'b1001: f = 1'b0; // Specified 0s
            4'b0110, 4'b1101, 4'b1010, 4'b1011, 4'b1011: f = 1'b1; // Handle don't-cares as convenient
            default: f = 1'b0; // Handle remaining don’t-cares, default to 0
        endcase
    end

endmodule
