module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	reg [2:0] state;
	reg [2:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or in) begin
		case(state)
			0: begin // Initial state
				if (in == 1) begin
					next_state = 1;
				end else begin
					next_state = 0;
				end
			end
			1: begin // Check for consecutive 1s
				if (in == 1) begin
					next_state = 2;
				end else begin
					next_state = 0;
				end
			end
			2: begin // Check for 0111110
				if (in == 1) begin
					next_state = 3;
				end else begin
					next_state = 0;
				end
			end
			3: begin // Check for 01111110 or error
				if (in == 1) begin
					next_state = 4;
				end else begin
					next_state = 0;
				end
			end
			4: begin // Check for error or flag
				if (in == 1) begin
					next_state = 5;
				end else begin
					next_state = 0;
				end
			end
			5: begin // Check for error
				if (in == 1) begin
					next_state = 6;
				end else begin
					next_state = 0;
				end
			end
			6: begin // Check for error
				if (in == 1) begin
					next_state = 6;
				end else begin
					next_state = 0;
				end
			end
		endcase
	end
	
	always @(state) begin
		case(state)
			0: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			1: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			2: begin
				disc = 0;
				flag = 0;
				err = 0;
			end
			3: begin
				disc = 1;
				flag = 0;
				err = 0;
			end
			4: begin
				disc = 0;
				flag = 1;
				err = 0;
			end
			5: begin
				disc = 0;
				flag = 0;
				err = 1;
			end
			6: begin
				disc = 0;
				flag = 0;
				err = 1;
			end
		endcase
	end
	
endmodule
