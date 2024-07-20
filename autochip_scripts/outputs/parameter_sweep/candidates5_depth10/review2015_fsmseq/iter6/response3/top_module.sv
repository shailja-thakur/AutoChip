module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	reg [2:0] bit_counter; // added bit_counter variable

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
			bit_counter <= 0;
		end else begin
			state <= next_state;
			if (start_shifting) begin
				bit_counter <= bit_counter + 1;
				if (bit_counter == 3) begin
					start_shifting <= 0;
					bit_counter <= 0;
				end
			end
		end
	end

	always @(state or data) begin
		next_state = state;

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
				if (data === 1'b0) begin
					next_state = 3;
				end else begin
					next_state = 0;
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
