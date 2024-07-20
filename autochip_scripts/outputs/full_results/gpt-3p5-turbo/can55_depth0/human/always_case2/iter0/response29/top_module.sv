module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

    always @* begin
        case (in)
            4'b0000: pos = 2'b00;  // Input is zero, output is zero
            4'b0001: pos = 2'b00;  // Input is 1 at position 0, output is zero
            4'b0010: pos = 2'b01;  // Input is 1 at position 1, output is 1
            4'b0011: pos = 2'b01;  // Input is 1 at position 0, output is 1
            4'b0100: pos = 2'b10;  // Input is 1 at position 2, output is 2
            4'b0101: pos = 2'b10;  // Input is 1 at position 0, output is 2
            4'b0110: pos = 2'b10;  // Input is 1 at position 1, output is 2
            4'b0111: pos = 2'b10;  // Input is 1 at position 0, output is 2
            4'b1000: pos = 2'b11;  // Input is 1 at position 3, output is 3
            4'b1001: pos = 2'b11;  // Input is 1 at position 0, output is 3
            4'b1010: pos = 2'b11;  // Input is 1 at position 1, output is 3
            4'b1011: pos = 2'b11;  // Input is 1 at position 0, output is 3
            4'b1100: pos = 2'b11;  // Input is 1 at position 2, output is 3
            4'b1101: pos = 2'b11;  // Input is 1 at position 0, output is 3
            4'b1110: pos = 2'b11;  // Input is 1 at position 1, output is 3
            4'b1111: pos = 2'b11;  // All inputs are high, output is 3
        endcase
    end

endmodule
