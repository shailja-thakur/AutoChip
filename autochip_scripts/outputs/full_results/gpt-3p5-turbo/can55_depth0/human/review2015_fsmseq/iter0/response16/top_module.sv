module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [2:0] state;
	reg start_shifting;

	// State definitions
	parameter S0 = 3'd0;
	parameter S1 = 3'd1;
	parameter S2 = 3'd2;
	parameter S3 = 3'd3;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0; // Reset to initial state
			start_shifting <= 0; // Reset the start_shifting signal
		end else begin
			case (state)
				S0: if (data) state <= S1;
				S1: if (data) state <= S2;
				S2: if (data) state <= S3;
				S3: if (!data) state <= S0;
			endcase
		end
	end

	// Output logic
	always @(*) begin
		if (state == S3)
			start_shifting = 1;
		else
			start_shifting = 0;
	end
	
endmodule
