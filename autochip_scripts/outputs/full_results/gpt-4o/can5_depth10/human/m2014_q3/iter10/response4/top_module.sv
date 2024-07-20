module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            // Define the outputs based on given Karnaugh map
            4'b0010, 4'b1010, 4'b1101, 4'b1001                                     : f = 1'b0; // Specified 0s
            4'b1110, 4'b1111, 4'b1011, 4'b0111, 4'b0110, 4'b1100, 4'b1101, 4'b1010: f = 1'b1; // Specified 1s & don't-care set to 1 for convenient grouping/simplification
            default                                                             : f = 1'b0; // Handle remaining don’t-cares, default to 0
        endcase
    end

endmodule
