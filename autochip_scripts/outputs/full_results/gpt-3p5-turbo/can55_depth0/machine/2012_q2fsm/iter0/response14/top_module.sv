module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	reg [2:0] state;
	
	// Initial state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else
			state <= state;
	end
	
	// State transitions
	always @(posedge clk) begin
		case (state)
			3'b000: begin
				if (w)
					state <= 3'b001;
				else
					state <= 3'b000;
			end
			3'b001: begin
				if (w)
					state <= 3'b010;
				else
					state <= 3'b001;
			end
			3'b010: begin
				if (w)
					state <= 3'b100;
				else
					state <= 3'b010;
			end
			3'b011: begin
				if (w)
					state <= 3'b111;
				else
					state <= 3'b000;
			end
			3'b100: begin
				if (w)
					state <= 3'b100;
				else
					state <= 3'b010;
			end
			3'b101: begin
				if (w)
					state <= 3'b111;
				else
					state <= 3'b110;
			end
			default: state <= 3'b000;
		endcase
	end
	
	// Output logic
	always @(posedge clk) begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1;
		else
			z <= 0;
	end
	
endmodule
