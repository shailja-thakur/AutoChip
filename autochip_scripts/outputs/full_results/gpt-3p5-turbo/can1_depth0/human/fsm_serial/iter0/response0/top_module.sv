module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	parameter IDLE = 2'b00;
	parameter START = 2'b01;
	parameter DATA = 2'b10;
	parameter STOP = 2'b11;
	
	reg [1:0] state, next_state;
	reg done;
	reg [6:0] count;
	reg error;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			error <= 0;
			done <= 0;
		end else begin
			state <= next_state;
			count <= count + 1;
			error <= in & (state == STOP);
			done <= (state == STOP) & ~error;
		end
	end
	
	always @(state, in) begin
		case (state)
			IDLE: begin
				if (in == 1'b1) begin
					next_state = START;
					count <= 0;
				end else begin
					next_state = IDLE;
				end
			end
			
			START: begin
				if (count == 7) begin
					next_state = DATA;
					count <= 0;
				end else begin
					next_state = START;
					count <= count + 1;
				end
			end
			
			DATA: begin
				if (count == 7) begin
					next_state = STOP;
					count <= 0;
				end else begin
					next_state = DATA;
					count <= count + 1;
				end
			end
			
			STOP: begin
				if (count == 1) begin
					if (in == 1'b0) begin
						next_state = IDLE;
					end else begin
						error <= 1;
						next_state = STOP;
					end
				end else begin
					next_state = STOP;
					count <= count + 1;
				end
			end
		endcase
	end
	
endmodule
