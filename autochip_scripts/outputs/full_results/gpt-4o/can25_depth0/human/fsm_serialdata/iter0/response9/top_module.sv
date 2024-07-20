module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// State encoding
	localparam IDLE = 3'd0,
			   START = 3'd1,
			   DATA = 3'd2,
			   STOP = 3'd3;

	reg [2:0] state, next_state;
	reg [7:0] data_buffer;
	reg [2:0] bit_count;

	//State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	//Next state logic
	always @(*) begin
		case(state)
			IDLE: begin
				if (in == 1'b0)
					next_state = START;
				else
					next_state = IDLE;
			end
			
			START: begin
				next_state = DATA;
			end
			
			DATA: begin
				if (bit_count == 3'd7)
					next_state = STOP;
				else
					next_state = DATA;
			end
			
			STOP: begin
				if (in == 1'b1)
					next_state = IDLE;
				else
					next_state = STOP;
			end
			
			default: next_state = IDLE;
		endcase
	end

	//Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			data_buffer <= 8'h00;
			bit_count <= 3'd0;
			out_byte <= 8'h00;
			done <= 1'b0;
		end else begin
			case(state)
				IDLE: begin
					done <= 1'b0;
				end
				
				START: begin
					data_buffer <= 8'h00;
					bit_count <= 3'd0;
				end
				
				DATA: begin
					data_buffer[bit_count] <= in;
					if (bit_count < 3'd7)
						bit_count <= bit_count + 1'b1;
				end
				
				STOP: begin
					if (in == 1'b1) begin
						out_byte <= data_buffer;
						done <= 1'b1;
					end
				end
			endcase
		end
	end

endmodule
