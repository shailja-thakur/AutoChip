module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;
	reg start_shifting;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'd0;
			start_shifting <= 1'b0;
		end else begin
			case(state)
				4'd0: if (data) state <= 4'd1; // Transition to state 1 if data is high
				4'd1: if (data) state <= 4'd2; // Transition to state 2 if data is high
				       else state <= 4'd0;   // Transition to state 0 if data is low       
				4'd2: if (data) state <= 4'd3; // Transition to state 3 if data is high
				       else state <= 4'd0;   // Transition to state 0 if data is low
				4'd3: if (data) begin       // Transition to state 4 if data is high and set start_shifting high
						state <= 4'd4;
						start_shifting <= 1'b1;
				       end else begin
						state <= 4'd0;     // Transition to state 0 if data is low
						start_shifting <= 1'b0;
				       end
				4'd4: state <= 4'd4;        // Stay in state 4 until reset
			endcase
		end
	end

endmodule
