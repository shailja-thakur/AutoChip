module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	reg [3:0] state;
	reg [3:0] next_state;
	
	parameter IDLE = 4'd0;
	parameter S1 = 4'd1;
	parameter S2 = 4'd2;
	parameter S3 = 4'd3;
	parameter S4 = 4'd4;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or data) begin
		case (state)
			IDLE: begin
				if (data) begin
					next_state = S1;
				end else begin
					next_state = IDLE;
				end
			end
			
			S1: begin
				if (data) begin
					next_state = S1;
				end else begin
					next_state = S2;
				end
			end
			
			S2: begin
				if (data) begin
					next_state = S1;
				end else begin
					next_state = S3;
				end
			end
			
			S3: begin
				if (data) begin
					next_state = S4;
				end else begin
					next_state = S2;
				end
			end
			
			S4: begin
				if (data) begin
					start_shifting = 1;
					next_state = S1;
				end else begin
					next_state = S2;
				end
			end
		endcase
	end

endmodule
