module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case(x)
        4'b00??: f = 1;
        4'b0100: f = 0;
        4'b011?: f = 0;
        4'b11??: f = 1;
        4'b1000: f = 1;
        4'b1??1: f = 0;
        default: f = 1;
    endcase
end

endmodule
