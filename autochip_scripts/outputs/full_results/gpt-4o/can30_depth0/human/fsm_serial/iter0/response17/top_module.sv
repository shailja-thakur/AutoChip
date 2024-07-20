module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// State encoding
	localparam IDLE = 3'd0;
	localparam START = 3'd1;
	localparam DATA = 3'd2;
	localparam STOP = 3'd3;
	localparam ERROR = 3'd4;
	
	reg [2:0] state, next_state;
	reg [7:0] data_reg;
	reg [2:0] bit_count;

	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Determine next state
	always @(*) begin
		case (state)
			IDLE: begin
				done = 0;
				if (in == 0)
					next_state = START;
				else
					next_state = IDLE;
			end

			START: begin
				done = 0;
				next_state = DATA;
			end

			DATA: begin
				done = 0;
				if (bit_count < 8)
					next_state = DATA;
				else
					next_state = STOP;
			end

			STOP: begin
				if (in == 1) begin
					done = 1;
					next_state = IDLE;
				end else begin
					done = 0;
					next_state = ERROR;
				end
			end

			ERROR: begin
				done = 0;
				if (in == 1)
					next_state = IDLE;
				else
					next_state = ERROR;
			end

			default: begin
				done = 0;
				next_state = IDLE;
			end
		endcase
	end
	
	// Bit counter and Data Register
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			bit_count <= 0;
			data_reg <= 0;
		end else if (state == DATA) begin
			bit_count <= bit_count + 1;
			data_reg <= {in, data_reg[7:1]};
		end else begin
			bit_count <= 0;
			data_reg <= 0;
		end
	end

endmodule
