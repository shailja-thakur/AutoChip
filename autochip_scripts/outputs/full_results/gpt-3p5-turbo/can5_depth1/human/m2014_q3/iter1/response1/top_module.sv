module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        4'b00??: f = 0;
        4'b010?: f = 1;
        4'b011?: f = 0;
        4'b1???: f = 1;
        default: f = 0;
    endcase
end

endmodule
