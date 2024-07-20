module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg [2:0] next_state;
	reg disc;
	reg flag;
	reg err;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		disc = 0;
		flag = 0;
		err = 0;
		
		case (state)
			3'b000: begin // Initial state
				if (in) begin
					next_state = 3'b001;
				end else begin
					next_state = 3'b000;
				end
			end
			
			3'b001: begin // Looking for 0111110
				if (in) begin
					next_state = 3'b010;
				end else begin
					next_state = 3'b000;
				end
			end
			
			3'b010: begin // Looking for 01111110
				if (in) begin
					next_state = 3'b100;
				end else begin
					next_state = 3'b000;
				end
			end
			
			3'b100: begin // Flag detected
				next_state = 3'b000;
				flag = 1;
			end
		endcase
		
		if (state[2] && in) begin // Checking for error condition
			next_state = 3'b000;
			err = 1;
		end
		
		if (state[1]) begin // Discarding bit after 5 consecutive 1s
			disc = 1;
		end
	end

endmodule
