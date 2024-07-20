module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);
	// Define state enumeration
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BIT,
		STOP_BIT
	} state_type;

	reg [2:0] state;
	reg [2:0] next_state;
	reg [7:0] shift_register;
	reg count;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			shift_register <= 8'b0;
			count <= 0;
			done <= 0;
		end
		else begin
			state <= next_state;
			shift_register <= {shift_register[6:0], in};
		end
	end

	always @* begin
		case (state)
			IDLE:
				if (in == 1'b0)
					next_state = START_BIT;
				else
					next_state = IDLE;
			START_BIT:
				if (in == 1'b0) begin
					next_state = DATA_BIT;
					count = 0;
				end
				else begin
					next_state = IDLE;
				end
			DATA_BIT:
				if (count == 7)
					next_state = STOP_BIT;
				else
					next_state = DATA_BIT;
			STOP_BIT:
				if (in == 1'b1) begin
					next_state = IDLE;
					done = 1;
					out_byte = shift_register[6:0];
				end
				else
					next_state = STOP_BIT;
			default:
				next_state = IDLE;
		endcase
	end
endmodule
