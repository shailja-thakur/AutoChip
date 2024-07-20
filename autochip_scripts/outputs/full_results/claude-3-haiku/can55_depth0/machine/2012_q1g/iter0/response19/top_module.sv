module top_module (
    input [4:0] x, // Input x is a 5-bit signal
    output logic f // Output f is a 1-bit signal
);

always_comb begin
    case (x)
        5'b00000, 5'b00001, 5'b00100, 5'b00101, 5'b00110, 5'b01110, 5'b01111: f = 1'b1; // Output f is 1 for x = 0, 1, 4, 5, 6, 14, 15
        5'b00010, 5'b00011, 5'b00111, 5'b01000, 5'b01001, 5'b01010, 5'b01011, 5'b01101, 5'b01101: f = 1'b0; // Output f is 0 for x = 2, 3, 7, 8, 9, 10, 11, 13, 13
        default: f = 1'b0; // Default case for any other input value
    endcase
end

endmodule
