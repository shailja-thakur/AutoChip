module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// State definition
	typedef enum logic [2:0] {
		IDLE,
		START,
		READ,
		STOP
	} state_t;
	
	// Register declaration
	reg [2:0] state_reg, next_state;
	reg [7:0] data_reg;
	reg done_reg;
	reg [2:0] bit_counter;
	
	// Assign default values to registers
	assign next_state = state_reg;
	assign out_byte = data_reg;
	assign done = done_reg;
	
	// Synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			state_reg <= IDLE;
			bit_counter <= 0;
			done_reg <= 0;
		end else begin
			state_reg <= next_state;
			bit_counter <= bit_counter;
			done_reg <= done_reg;
		end
	end
	
	// Combinational logic
	always @* begin
		case (state_reg)
			IDLE:
				if (in == 1'b0)
					next_state = START;
				else
					next_state = IDLE;
			START:
				if (in == 1'b0)
					next_state = READ;
				else
					next_state = IDLE;
			READ:
				if (in == 1'b1)
					next_state = STOP;
				else begin
					if (bit_counter == 7)
						next_state = START;
					else
						next_state = READ;
				end
			STOP:
				if (in == 1'b1) begin
					done_reg = 1;
					next_state = IDLE;
				end else
					next_state = STOP;
		endcase
	end
	
	always @(posedge clk) begin
		if (reset)
			data_reg <= 0;
		else if (state_reg == READ) begin
			data_reg <= {in, data_reg[7:1]};
			bit_counter <= bit_counter + 1;
		end
	end

endmodule
