module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	reg [3:0] state, next_state;
	reg [7:0] data;
	reg [2:0] bit_idx;

	// State encoding
	localparam IDLE = 4'd0;
	localparam START = 4'd1;
	localparam BIT0 = 4'd2;
	localparam BIT1 = 4'd3;
	localparam BIT2 = 4'd4;
	localparam BIT3 = 4'd5;
	localparam BIT4 = 4'd6;
	localparam BIT5 = 4'd7;
	localparam BIT6 = 4'd8;
	localparam BIT7 = 4'd9;
	localparam STOP = 4'd10;

	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_idx <= 3'd0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		next_state = state;
		case (state)
			IDLE: if (in == 0) next_state = START;
			START: next_state = BIT0;
			BIT0: next_state = BIT1;
			BIT1: next_state = BIT2;
			BIT2: next_state = BIT3;
			BIT3: next_state = BIT4;
			BIT4: next_state = BIT5;
			BIT5: next_state = BIT6;
			BIT6: next_state = BIT7;
			BIT7: next_state = STOP;
			STOP: if (in == 1) next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	// Output logic and data capture
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			done <= 0;
			out_byte <= 8'd0;
			data <= 8'd0;
		end else begin
			case (state)
				IDLE: begin
					done <= 0;
				end
				START: begin
					bit_idx <= 3'd0;
				end
				BIT0: begin
					data[0] <= in;
					bit_idx <= bit_idx + 1;
				end
				BIT1: begin
					data[1] <= in;
					bit_idx <= bit_idx + 1;
				end
				BIT2: begin
					data[2] <= in;
					bit_idx <= bit_idx + 1;
				end
				BIT3: begin
					data[3] <= in;
					bit_idx <= bit_idx + 1;
				end
				BIT4: begin
					data[4] <= in;
					bit_idx <= bit_idx + 1;
				end
				BIT5: begin
					data[5] <= in;
					bit_idx <= bit_idx + 1;
				end
				BIT6: begin
					data[6] <= in;
					bit_idx <= bit_idx + 1;
				end
				BIT7: begin
					data[7] <= in;
					bit_idx <= bit_idx + 1;
				end
				STOP: begin
					if (in == 1) begin
						out_byte <= data;
						done <= 1;
					end else begin
						done <= 0;
					end
				end
				default: begin
					done <= 0;
					out_byte <= 8'd0;
					data <= 8'd0;
				end
			endcase
		end
	end

endmodule
