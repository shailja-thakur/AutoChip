module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0000, 4'b1000, 4'b1010, 4'b1011: f = 1'b1; // Represent the 1 cells in the Karnaugh map
        4'b0001, 4'b0101, 4'b1001, 4'b1100, 4'b1101, 4'b1110, 4'b1111: f = 1'b0; // Represent the 0 cells in the Karnaugh map
        4'b0010, 4'b0011, 4'b0100, 4'b0110, 4'b0111, 4'b1010: f = 1'b1; // Represent the 1 cells in the Karnaugh map
        default: f = 1'b0;
    endcase
end

endmodule
