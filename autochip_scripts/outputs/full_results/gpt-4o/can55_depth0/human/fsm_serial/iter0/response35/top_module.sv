module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// Define state encoding
	typedef enum reg [2:0] {
		IDLE  = 3'b000,
		START = 3'b001,
		DATA  = 3'b010,
		STOP  = 3'b011,
		ERROR = 3'b100
	} state_t;
	
	state_t current_state, next_state;
	reg [2:0] bit_count;
	reg [7:0] data_reg;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic and output logic
	always @(*) begin
		next_state = current_state;
		done = 0;
		case (current_state)
			IDLE: begin
				if (in == 0)
					next_state = START;
				else
					next_state = IDLE;
			end
			
			START: begin
				if (in == 0)
					next_state = DATA;
				else
					next_state = ERROR;
			end
			
			DATA: begin
				if (bit_count == 3'b111)
					next_state = STOP;
				else
					next_state = DATA;
			end
			
			STOP: begin
				if (in == 1) begin
					done = 1;
					next_state = IDLE;
				end else
					next_state = ERROR;
			end
			
			ERROR: begin
				if (in == 1)
					next_state = IDLE;
				else
					next_state = ERROR;
			end
		endcase
	end

	// Bit count and data register logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			bit_count <= 3'b000;
			data_reg <= 8'b00000000;
		end else if (current_state == DATA) begin
			bit_count <= bit_count + 1;
			data_reg <= {in, data_reg[7:1]};
		end else begin
			bit_count <= 3'b000;
		end
	end

endmodule
