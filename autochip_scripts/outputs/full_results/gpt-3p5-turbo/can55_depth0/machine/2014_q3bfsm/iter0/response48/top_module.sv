module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000: // State A
					if (x) begin
						state <= 3'b001; // State B
					end
				3'b001: // State B
					if (x) begin
						state <= 3'b100; // State E
					end
				3'b100: // State E
					if (!x) begin
						state <= 3'b011; // State D
					end
				3'b011: // State D
					if (x) begin
						state <= 3'b011; // State C
					end
				3'b011: // State C
					if (!x) begin
						state <= 3'b011; // State C
					end
			endcase
		end
	end
	
	always @(state) begin
		if (state == 3'b100 || state == 3'b011) begin
			z <= 1'b1;
		end else begin
			z <= 1'b0;
		end
	end
	
endmodule
