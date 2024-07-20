module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0100, 4'b0111, 4'b1111: f = 1'b1;  // 01: 1
            4'b1000, 4'b1001, 4'b1100, 4'b1101: f = 1'b1;  // 10: 1, 11: 1
            4'b1010, 4'b1011: f = 1'b0;  // 10: 0
            4'b0001, 4'b0110, 4'b1001, 4'b0110: f = 1'b0; // Other 0s
            4'b0101, 4'b0011, 4'b0000: f = 1'b0;
            default: f = 1'b0; // Other values based on the map// Treat don't-cares
        endcase
    end

endmodule
