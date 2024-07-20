module top_module (
	input wire clk,
	input wire reset,
	input wire w,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // initial state is A
		else begin
			case (state)
				3'b000: if (w) state <= 3'b001; else state <= 3'b000; // transition from A to B if w=1, otherwise A to A
				3'b001: if (w) state <= 3'b010; else state <= 3'b100; // transition from B to C if w=1, otherwise B to D
				3'b010: if (w) state <= 3'b110; else state <= 3'b100; // transition from C to E if w=1, otherwise C to D
				3'b011: state <= 3'b000; // transition from D to A
				3'b100: if (w) state <= 3'b011; else state <= 3'b100; // transition from D to F if w=1, otherwise D to D
				3'b101: state <= 3'b001; // transition from E to B
				3'b110: state <= 3'b010; // transition from F to C
				default: state <= 3'b000;
			endcase
		end
	end
	
	always @(state) begin
		if (state == 3'b110 || state == 3'b101)
			z <= 1'b1;
		else
			z <= 1'b0;
	end

endmodule
