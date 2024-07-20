module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
	
	reg [3:0] delay;
	reg [3:0] counter;
	reg [3:0] remaining_time;
	reg [3:0] pattern;
	
	parameter IDLE = 2'b00;
	parameter SEARCH_PATTERN = 2'b01;
	parameter SHIFT_IN_DELAY = 2'b10;
	parameter COUNTING = 2'b11;
	
	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			state <= IDLE;
			counting <= 0;
			done <= 0;
			delay <= 0;
			counter <= 0;
			remaining_time <= 0;
		end
		else begin
			case(state)
				IDLE: begin
					if(data == 1'b1) begin
						if({pattern, data} == 4'b1101) begin
							delay <= 4'b0000;
							state <= SHIFT_IN_DELAY;
						end
						else begin
							delay <= delay;
							state <= SEARCH_PATTERN;
						end
					end
					else begin
						delay <= delay;
						state <= SEARCH_PATTERN;
					end
				end
				
				SEARCH_PATTERN: begin
					if(data == 1'b1) begin
						if({pattern, data} == 4'b1101) begin
							delay <= 4'b0000;
							state <= SHIFT_IN_DELAY;
						end
						else begin
							delay <= delay;
							state <= SEARCH_PATTERN;
						end
					end
					else begin
						delay <= delay;
						state <= SEARCH_PATTERN;
					end
				end
				
				SHIFT_IN_DELAY: begin
					if(data == 1'b1) begin
						delay <= {delay[2:0], data};
						state <= SHIFT_IN_DELAY;
					end
					else begin
						counting <= 1;
						state <= COUNTING;
					end
				end
				
				COUNTING: begin
					if(counter == ((delay + 1) * 1000) - 1) begin
						counting <= 0;
						done <= 1;
						state <= IDLE;
					end
					else begin
						counter <= counter + 1;
						state <= COUNTING;
					end
				end
				
				default: state <= IDLE;
			endcase
		end
	end
	
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			count <= 4'bxxxx;
		end
		else begin
			if(state == COUNTING) begin
				count <= remaining_time;
			end
			else begin
				count <= 4'bxxxx;
			end
		end
	end
	
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			remaining_time <= 4'bxxxx;
		end
		else begin
			if(state == COUNTING) begin
				remaining_time <= delay - counter/1000;
			end
			else begin
				remaining_time <= 4'bxxxx;
			end
		end
	end
	
endmodule
