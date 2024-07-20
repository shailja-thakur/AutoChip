module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting); 

	reg [3:0] state;
	reg start_shifting;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
		end else case (state)
			0: begin
				// Initial state
				if (data == 1'b1) state <= 1;
			end
			1: begin
				// State after receiving 1
				if (data == 1'b1) state <= 2;
				else state <= 0;
			end
			2: begin
				// State after receiving 11
				if (data == 1'b0) state <= 3;
				else if (data == 1'b1) state <= 2;
				else state <= 0;
			end
			3: begin
				// State after receiving 110
				if (data == 1'b1) state <= 4;
				else state <= 0;
			end
			4: begin
				// State after receiving 1101
				start_shifting <= 1;
				state <= 5;
			end
			5: begin
				// State after start_shifting is set
				start_shifting <= 1;
				state <= 5;
			end
		endcase
	end

endmodule
