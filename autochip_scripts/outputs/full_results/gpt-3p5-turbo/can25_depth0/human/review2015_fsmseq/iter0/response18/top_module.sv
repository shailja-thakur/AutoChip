module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg state;          // state variable to keep track of the FSM state
	reg [3:0] count;     // counter to keep track of the sequence

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;           // reset state to initial state
			count <= 0;           // reset count to 0
			start_shifting <= 0;  // set start_shifting to 0
		end else begin
			case (state)
				0: begin
					if (data) begin
						state <= 1;   // move to state 1 if data is high
					end else begin
						state <= 0;   // stay in state 0 if data is low
					end
				end
				1: begin
					if (data) begin
						state <= 2;   // move to state 2 if data is high
					end else begin
						state <= 0;   // move back to state 0 if data is low
					end
				end
				2: begin
					if (data) begin
						state <= 2;   // stay in state 2 if data is high
					end else begin
						state <= 3;   // move to state 3 if data is low
					end
				end
				3: begin
					if (data) begin
						state <= 1;   // move back to state 1 if data is high
					end else begin
						state <= 4;   // move to state 4 if data is low
					end
				end
				4: begin
					if (data) begin
						state <= 2;   // move back to state 2 if data is high
					end else begin
						state <= 0;   // move back to state 0 if data is low
					end
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 4 & count < 7) begin
			count <= count + 1;      // increment count when in state 4
		end else if (state == 0 | state == 1 | state == 2 | state == 3) begin
			count <= 0;              // reset count when not in state 4
		end
	end

	assign start_shifting = (count == 7);  // check if count reaches 7 to set start_shifting

endmodule
