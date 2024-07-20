module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	reg [2:0] state_reg;
	reg [2:0] next_state_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= 3'b000;
		else
			state_reg <= next_state_reg;
	end
	
	always @* begin
		case (state_reg)
			3'b000: begin
				if (w == 1'b0) next_state_reg = 3'b000;
				else if (w == 1'b1) next_state_reg = 3'b001;
			end
			3'b001: begin
				if (w == 1'b0) next_state_reg = 3'b010;
				else if (w == 1'b1) next_state_reg = 3'b011;
			end
			3'b010: begin
				if (w == 1'b0) next_state_reg = 3'b010;
				else if (w == 1'b1) next_state_reg = 3'b100;
			end
			3'b011: begin
				if (w == 1'b0) next_state_reg = 3'b000;
				else if (w == 1'b1) next_state_reg = 3'b110;
			end
			3'b100: begin
				if (w == 1'b0) next_state_reg = 3'b010;
				else if (w == 1'b1) next_state_reg = 3'b100;
			end
			3'b110: begin
				if (w == 1'b0) next_state_reg = 3'b100;
				else if (w == 1'b1) next_state_reg = 3'b010;
			end
			default: next_state_reg = 3'b000;
		endcase
	end
	
	assign z = (state_reg == 3'b100) || (state_reg == 3'b110);
	
endmodule
