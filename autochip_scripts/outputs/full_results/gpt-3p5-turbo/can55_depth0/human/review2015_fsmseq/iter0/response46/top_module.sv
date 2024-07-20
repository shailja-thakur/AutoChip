module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	assign start_shifting = (state == 4);

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else
			state <= next_state;
	end

	always @(state or data) begin
		case (state)
			0: begin
				if (data)
					next_state = 1;
				else
					next_state = 0;
			end
			1: begin
				if (data)
					next_state = 2;
				else
					next_state = 0;
			end
			2: begin
				if (data)
					next_state = 3;
				else
					next_state = 0;
			end
			3: begin
				if (data)
					next_state = 4;
				else
					next_state = 0;
			end
			4: begin
				next_state = 4;
			end
			default: begin
				next_state = 0;
			end
		endcase
	end
endmodule
