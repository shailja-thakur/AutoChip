module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// Define states using an enum
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	reg [7:0] data_byte;       // Stores the received data byte
	reg [2:0] state;           // Stores the current state of the FSM
	reg [2:0] next_state;      // Stores the next state of the FSM
	reg [2:0] bit_counter;     // Keeps track of the position of the current bit

	// Define local parameters
	localparam IDLE_VALUE = 3'b000;
	localparam START_BIT_VALUE = 3'b001;
	localparam DATA_BITS_VALUE = 3'b010;
	localparam STOP_BIT_VALUE = 3'b011;

	// Define states and output assignments
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE_VALUE;
			done <= 0;
			data_byte <= 8'b0;
			bit_counter <= 3'b0;
		end else begin
			state <= next_state;
			done <= 0;

			case (state)
				IDLE_VALUE: begin
					if (in == 1'b0) begin
						next_state <= START_BIT_VALUE;
						bit_counter <= 3'b0;
						data_byte <= 8'b0;
					end else begin
						next_state <= IDLE_VALUE;
					end
				end

				START_BIT_VALUE: begin
					if (in == 1'b0) begin
						next_state <= DATA_BITS_VALUE;
						bit_counter <= bit_counter + 1;
						data_byte[bit_counter] <= in;
					end else begin
						next_state <= IDLE_VALUE;
					end
				end

				DATA_BITS_VALUE: begin
					if (bit_counter == 3'b111) begin
						next_state <= STOP_BIT_VALUE;
						bit_counter <= bit_counter + 1;
						data_byte[bit_counter] <= in;
					end else if (in == 1'b0) begin
						bit_counter <= bit_counter + 1;
						data_byte[bit_counter] <= in;
					end else begin
						next_state <= IDLE_VALUE;
					end
				end

				STOP_BIT_VALUE: begin
					if (in == 1'b1) begin
						next_state <= IDLE_VALUE;
						bit_counter <= 3'b0;
						done <= 1;
						out_byte <= data_byte;
					end else begin
						next_state <= IDLE_VALUE;
					end
				end
			endcase
		end
	end

endmodule
