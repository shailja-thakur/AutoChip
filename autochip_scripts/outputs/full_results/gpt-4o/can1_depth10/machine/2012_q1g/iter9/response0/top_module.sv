module top_module (
    input [4:0] x,   // Correcting input width to 5 bits
    output logic f
);
    always_comb begin
        case (x)
            5'b00000: f = 1;
            5'b00001: f = 1;
            5'b00010: f = 0;
            5'b00011: f = 0;
            5'b00100: f = 1;
            5'b00101: f = 1;
            5'b00110: f = 1;
            5'b00111: f = 0;
            5'b01000: f = 0;
            5'b01001: f = 0;
            5'b01010: f = 0;
            5'b01011: f = 0;
            5'b01100: f = 1;
            5'b01101: f = 0;
            5'b01110: f = 1;
            5'b01111: f = 1;
            5'b10000: f = 0;  // Adding default handling for 5-bit values greater than 4'b1111
            5'b10001: f = 0;
            5'b10010: f = 0;
            5'b10011: f = 0;
            5'b10100: f = 0;
            5'b10101: f = 0;
            5'b10110: f = 0;
            5'b10111: f = 0;
            5'b11000: f = 0;
            5'b11001: f = 0;
            5'b11010: f = 0;
            5'b11011: f = 0;
            5'b11100: f = 0;
            5'b11101: f = 0;
            5'b11110: f = 0;
            5'b11111: f = 0;
            default:  f = 0;  // Default case
        endcase
    end
endmodule
