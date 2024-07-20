module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	reg [3:0] state, next_state;
	reg [2:0] bit_count;
	reg [7:0] byte_data;

	parameter IDLE = 4'b0000,
			  START = 4'b0001,
			  BIT0 = 4'b0010,
			  BIT1 = 4'b0011,
			  BIT2 = 4'b0100,
			  BIT3 = 4'b0101,
			  BIT4 = 4'b0110,
			  BIT5 = 4'b0111,
			  BIT6 = 4'b1000,
			  BIT7 = 4'b1001,
			  STOP = 4'b1010;

	// State transition logic
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: if (in == 0) next_state = START; else next_state = IDLE;
			START: next_state = BIT0;
			BIT0: next_state = BIT1;
			BIT1: next_state = BIT2;
			BIT2: next_state = BIT3;
			BIT3: next_state = BIT4;
			BIT4: next_state = BIT5;
			BIT5: next_state = BIT6;
			BIT6: next_state = BIT7;
			BIT7: next_state = STOP;
			STOP: if (in == 1) next_state = IDLE; else next_state = STOP;
			default: next_state = IDLE;
		endcase
	end

	// Output and state-specific logic
	always @(posedge clk) begin
		if (reset) begin
			bit_count <= 3'd0;
			byte_data <= 8'd0;
			out_byte <= 8'd0;
			done <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					done <= 1'b0;
				end
				START: begin
					bit_count <= 3'd0;
					byte_data <= 8'd0;
				end
				BIT0: begin
					byte_data[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				BIT1: begin
					byte_data[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				BIT2: begin
					byte_data[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				BIT3: begin
					byte_data[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				BIT4: begin
					byte_data[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				BIT5: begin
					byte_data[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				BIT6: begin
					byte_data[bit_count] <= in;
					bit_count <= bit_count + 1;
				end
				BIT7: begin
					byte_data[bit_count] <= in;
				end
				STOP: begin
					if (in == 1) begin
						out_byte <= byte_data;
						done <= 1'b1;
					end else begin
						done <= 1'b0;
					end
				end
			endcase
		end
	end
endmodule
