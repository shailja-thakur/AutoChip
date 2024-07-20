module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        4'b00?: f = 0;
        4'b0101: f = 1;
        4'b11??: f = 1;
        4'b10??, 4'b11??, 4'b1???, 4'b?111: f = 0;
        default: f = 0; // Don't cares
    endcase
end

endmodule
