module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0001, 4'b0100, 4'b1010: f = 1'b0; // Make sure to include only defined 0s
            4'b1100, 4'b1101, 4'b1110, 4'b1111, 4'b0110: f = 1'b1; // Include only defined 1s
            4'b0011: f = 1'b0; // Correcting specific don't-care that should be 0
            default: f = 1'b0; // Handle remaining don’t-cares, default to 0
        endcase
    end

endmodule
