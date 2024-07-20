module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);


	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(state or data) begin
		case(state)
			3'b000: begin // S
				if (data)
					next_state = 3'b001; // S1
				else
					next_state = 3'b000; // S
			end

			3'b001: begin // S1
				if (data)
					next_state = 3'b011; // S11
				else
					next_state = 3'b000; // S
			end

			3'b011: begin // S11
				if (data)
					next_state = 3'b011; // S11
				else
					next_state = 3'b110; // S110
			end

			3'b110: begin // S110
				if (data)
					next_state = 3'b111; // Done
				else
					next_state = 3'b000; // S
			end

			3'b111: begin // Done
				next_state = 3'b111; // Done
			end
		endcase
	end

	always @(state) begin
		if (state == 3'b111) begin
			start_shifting = 1'b1;
		end else begin
			start_shifting = 1'b0;
		end
	end

endmodule
