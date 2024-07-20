module top_module (
    input [4:1] x,
    output logic f
);


always_comb begin
    case (x)
        // x[3]x[4]   00 01 11 10
        4'b0000: f = 1'b0;
        4'b0001, 4'b0100, 4'b0101: f = 1'b0; // Don't care values
        4'b0010, 4'b0011, 4'b0110, 4'b1000: f = 1'b1;
        4'b0111, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111: f = 1'b1; // Don't care values
        default: f = 1'b0; // Default output
    endcase
end


endmodule
