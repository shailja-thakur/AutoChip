module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case(x)
        4'b00??: f = 1;
        4'b010?: f = 0;
        4'b011?: f = 1;
        4'b100?: f = 1;
        4'b101?: f = 1;
        default: f = 0;
    endcase
end
endmodule
