module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	reg sync_reset; // added synchronous reset signal

	always @(posedge clk) begin
		if (sync_reset) begin
			state <= 4'd0;
		end else begin
			state <= next_state;
		end
	end

	always @(state or data or sync_reset) begin
		next_state = state;
		start_shifting <= 0;

		case (state)
			0: begin
				if (data === 1'b1) begin
					next_state = 4'd1;
				end
			end
			1: begin
				if (data === 1'b1) begin
					next_state = 4'd2;
				end else begin
					next_state = 4'd0;
				end
			end
			2: begin
				if (data === 1'b0) begin
					next_state = 4'd3;
				end else begin
					next_state = 4'd0;
				end
			end
			3: begin
				if (data === 1'b1) begin
					next_state = 4'd4;
				end else begin
					next_state = 4'd0;
				end
			end
			4: begin
				if (data === 1'b1) begin
					next_state = 4'd4;
				end else begin
					next_state = 4'd0;
					start_shifting <= 1;
				end
			end
		endcase
	end

	always @(posedge clk) begin
		if (reset) begin
			sync_reset <= 1'b1;
		end else begin
			sync_reset <= 1'b0;
		end
	end

endmodule
