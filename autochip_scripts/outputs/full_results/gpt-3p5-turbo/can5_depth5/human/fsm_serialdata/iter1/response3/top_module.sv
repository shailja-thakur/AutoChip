module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// define states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state;

	reg [2:0] current_state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	always @(current_state or in) begin
		case (current_state)
			IDLE:
				if (reset)
					next_state <= IDLE;
				else if (in == 1'b0)
					next_state <= START_BIT;
				else
					next_state <= IDLE;
			START_BIT:
				if (in == 1'b0)
					next_state <= DATA_BITS;
				else
					next_state <= START_BIT;
			DATA_BITS:
				begin
					if (in == 1'b1)
						next_state <= STOP_BIT;
					else
						next_state <= DATA_BITS;
				end
			STOP_BIT:
				if (in == 1'b1)
					begin
						done <= 1'b1;
						next_state <= IDLE;
					end
				else
					next_state <= IDLE;
			default:
				next_state <= IDLE;
		endcase
	end

	always @(posedge clk) begin
		case (current_state)
			DATA_BITS:
				out_byte <= {in, out_byte[7:1]}; // shift in the data bits
			default:
				out_byte <= 8'b0;
		endcase
	end

endmodule
