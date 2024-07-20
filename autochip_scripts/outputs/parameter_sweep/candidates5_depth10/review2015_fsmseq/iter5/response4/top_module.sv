module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state; // added next_state variable

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
		end else begin
			state <= next_state; // updated state using next_state
		end
	end

	always @(state or data) begin
		next_state = state; // initialize next_state to current state

		case (state)
			0: begin
				if (data === 1'b1) begin
					next_state = 1;
				end else begin
					next_state = 0;
				end
			end
			1: begin
				if (data === 1'b1) begin
					next_state = 2;
				end else begin
					next_state = 0;
				end
			end
			2: begin
				if (data === 1'b1) begin // corrected condition to check for 1'b1
					next_state = 3; // changed state to 3 when data is 1'b1
				else if (data === 1'b0) begin // added else if condition to check for 1'b0
					next_state = 0; // changed state to 0 when data is 1'b0
				end
			end
			3: begin
				if (data === 1'b1) begin
					next_state = 4;
				end else begin
					next_state = 0;
				end
			end
			4: begin
				if (data === 1'b1) begin
					next_state = 4;
				end else begin
					next_state = 0;
					start_shifting <= 1;
				end
			end
		endcase
	end

endmodule
