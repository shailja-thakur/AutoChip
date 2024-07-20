module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        4'b00??: f = 1'b0; // Assign don't care values to 0
        4'b010?: f = 1'b0;
        4'b0111: f = 1'b1;
        4'b111?: f = 1'b1;
        4'b1???: f = 1'b0;
        default: f = 1'b0; // Default case, assign f to 0
    endcase
end

endmodule
