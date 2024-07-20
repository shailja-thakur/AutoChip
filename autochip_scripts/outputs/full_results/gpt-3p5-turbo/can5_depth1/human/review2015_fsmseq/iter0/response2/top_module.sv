module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// State definitions
	parameter S_IDLE = 2'b00;
	parameter S_1 = 2'b01;
	parameter S_10 = 2'b10;
	parameter S_110 = 2'b11;
	
	reg [1:0] state, next_state;
	reg [3:0] shift_count;
	
	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S_IDLE;
			shift_count <= 0;
		end
		else begin
			state <= next_state;
			shift_count <= shift_count + 1;
		end
	end
	
	// Combinational logic
	always @* begin
		case (state)
			S_IDLE: begin
				if (data == 1'b1)
					next_state = S_1;
				else
					next_state = S_IDLE;
			end
			
			S_1: begin
				if (data == 1'b1)
					next_state = S_10;
				else
					next_state = S_IDLE;
			end
			
			S_10: begin
				if (data == 1'b0)
					next_state = S_110;
				else
					next_state = S_IDLE;
			end
			
			S_110: begin
				if (data == 1'b1) begin
					next_state = S_IDLE;
					start_shifting = 1;
				end
				else
					next_state = S_110;
			end
		endcase
	end
endmodule
