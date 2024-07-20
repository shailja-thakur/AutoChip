module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output reg [3:0] count,
	output reg counting,
	output reg done,
	input wire ack );

	reg [2:0] state, next_state;
	reg [3:0] delay, next_delay;
	reg [9:0] counter, next_counter;
	reg [3:0] bit_counter, next_bit_counter;
	reg [13:0] total_count, next_total_count;
	
	localparam S_IDLE = 3'b000;
	localparam S_PATTERN = 3'b001;
	localparam S_LOAD_DELAY = 3'b010;
	localparam S_COUNT = 3'b011;
	localparam S_DONE = 3'b100;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= S_IDLE;
			counter <= 0;
			bit_counter <= 0;
			delay <= 4'b0000;
			count <= 4'b0000;
			total_count <= 14'b0;
		end else begin
			state <= next_state;
			counter <= next_counter;
			bit_counter <= next_bit_counter;
			delay <= next_delay;
			total_count <= next_total_count;
		end
	end

	always @* begin
		next_state = state;
		next_counter = counter;
		next_bit_counter = bit_counter;
		next_delay = delay;
		next_total_count = total_count;
		counting = 0;
		done = 0;

		case (state)
			S_IDLE: begin
				if ({bit_counter, data} == 4'b1101) begin
					next_bit_counter = 0;
					next_state = S_PATTERN;
				end else begin
					if (bit_counter == 3)
						next_bit_counter = 0;
					else
						next_bit_counter = bit_counter + 1;
				end
			end
			S_PATTERN: begin
				next_delay = {next_delay[2:0], data};
				next_bit_counter = bit_counter + 1;
				if (bit_counter == 3) begin
					next_state = S_LOAD_DELAY;
					next_total_count = {next_delay[2:0], data, 10'b0};
				end
			end
			S_LOAD_DELAY: begin
				next_state = S_COUNT;
				next_counter = 1000;
				count = next_delay;
			end
			S_COUNT: begin
				counting = 1;
				if (counter == 0) begin
					next_total_count = total_count - 1;
					if (total_count == 0) begin
						next_state = S_DONE;
						done = 1;
					end else begin
						next_counter = 1000;
						count = count - 1;
					end
				end else begin
					next_counter = counter - 1;
				end
			end
			S_DONE: begin
				done = 1;
				if (ack) begin
					next_state = S_IDLE;
					next_counter = 0;
					next_bit_counter = 0;
					next_delay = 0;
					next_total_count = 0;
				end
			end
		endcase
	end
	
endmodule
