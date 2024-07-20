module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				3'b000: state <= (w == 1) ? 3'b001 : 3'b000; // A to B or A to A
				3'b001: state <= (w == 1) ? 3'b010 : 3'b011; // B to C or B to D
				3'b010: state <= (w == 1) ? 3'b100 : 3'b011; // C to E or C to D
				3'b011: state <= (w == 1) ? 3'b111 : 3'b000; // D to F or D to A
				3'b100: state <= (w == 1) ? 3'b100 : 3'b101; // E to E or E to D
				3'b101: state <= (w == 1) ? 3'b010 : 3'b011; // F to C or F to D
				default: state <= 0;
			endcase
		end
	end
	assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;
endmodule
