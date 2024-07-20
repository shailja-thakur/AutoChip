module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg disc, flag, err;
	reg [2:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001;
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end else begin
			state <= next_state;
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end
	end
	
	always @(state or in) begin
		next_state = state;
		case (state)
			3'b001:
				if (in) begin
					next_state = 3'b010;
				end else if (!in) begin
					next_state = 3'b001;
				end
			3'b010:
				if (in) begin
					next_state = 3'b011;
				end else if (!in) begin
					next_state = 3'b001;
				end
			3'b011:
				if (in) begin
					next_state = 3'b100;
					disc <= 1'b1;
				end else if (!in) begin
					next_state = 3'b001;
				end
			3'b100:
				if (in) begin
					next_state = 3'b101;
				end else if (!in) begin
					next_state = 3'b001;
				end
			3'b101:
				if (in) begin
					next_state = 3'b110;
				end else if (!in) begin
					next_state = 3'b001;
				end
			3'b110:
				if (in) begin
					next_state = 3'b010;
				end else if (!in) begin
					next_state = 3'b001;
				end
		endcase
	end
	
	always @(state) begin
		case (state)
			3'b011: flag <= 1'b1;
			3'b100: err <= 1'b1;
		endcase
	end
	
endmodule
