module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0000,
            4'b0001,
            4'b0011,
            4'b0100,
            4'b0111,
            4'b1000,
            4'b1001,
            4'b1011: f = 1'b0; // Defined 0s
            4'b0110,
            4'b1100,
            4'b1101: f = 1'b1; // Correcting specific don't-care that should be 1
            default: f = 1'b1; // Handle remaining don’t-cares, default to 1
        endcase
    end

endmodule
