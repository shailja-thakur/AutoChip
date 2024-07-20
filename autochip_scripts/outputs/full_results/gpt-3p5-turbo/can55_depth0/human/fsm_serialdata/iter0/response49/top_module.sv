module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
	
	// Define the states of the finite state machine
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;
	
	// Define the signals for the FSM
	reg [2:0] state;
	reg [7:0] data;
	reg [7:0] out_byte_reg;

	// Initialize the outputs
	assign out_byte = out_byte_reg;
	assign done = (state == STOP_BIT) ? 1 : 0;
	
	// FSM
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data <= 0;
			out_byte_reg <= 0;
		end else begin
			case (state)
				IDLE:
					if (in == 1) begin
						state <= START_BIT;
						data <= 0;
					end
				START_BIT:
					state <= DATA_BITS;
				DATA_BITS:
					if (in == 1) begin
						data <= {data[6:0], in};
					end else begin
						state <= STOP_BIT;
					end
				STOP_BIT:
					if (in == 1) begin
						out_byte_reg <= data;
						state <= IDLE;
					end
			endcase
		end
	end
	
endmodule
