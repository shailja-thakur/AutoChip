module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state, next_state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		case (state)
			3'b000: begin // State 0: Current bit is 0
				if (in) begin
					next_state = 3'b001;
				end else begin
					next_state = 3'b000;
				end
			end
			3'b001: begin // State 1: 1 bit seen
				if (!in) begin
					next_state = 3'b000;
				end else begin
					next_state = 3'b010;
				end
			end
			3'b010: begin // State 2: 2 bits seen
				if (!in) begin
					next_state = 3'b000;
				end else begin
					next_state = 3'b011;
				end
			end
			3'b011: begin // State 3: 3 bits seen
				if (!in) begin
					next_state = 3'b000;
				end else if (flag) begin
					next_state = 3'b100;
				end else if (err) begin
					next_state = 3'b101;
				end else begin
					next_state = 3'b011;
				end
			end
			3'b100: begin // State 4: Flag sequence seen
				if (!in) begin
					next_state = 3'b000;
				end else begin
					next_state = 3'b100;
				end
			end
			3'b101: begin // State 5: Error sequence seen
				if (!in) begin
					next_state = 3'b000;
				end else begin
					next_state = 3'b101;
				end
			end
		endcase
	end

	// Output logic
	assign disc = state == 3'b100;
	assign flag = state == 3'b011;
	assign err = state == 3'b101;

endmodule
