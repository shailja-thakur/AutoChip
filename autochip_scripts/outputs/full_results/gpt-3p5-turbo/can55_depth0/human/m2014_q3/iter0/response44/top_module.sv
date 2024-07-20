module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case(x)
        4'b00??: f = 1; // choose to output 1 for don't care inputs
        4'b0100: f = 0;
        4'b0101: f = 0;
        4'b011?: f = 1; // choose to output 1 for don't care inputs
        4'b100?: f = 1; // choose to output 1 for don't care inputs
        4'b101?: f = 1; // choose to output 1 for don't care inputs
        4'b11??: f = 1; // choose to output 1 for don't care inputs
        4'b10??: f = 0; // choose to output 0 for don't care inputs
        default: f = 0;
    endcase
end

endmodule
