module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	/* Enum defining the states of the FSM */
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BIT,
		STOP_BIT
	} state_t;
	
	/* Register to hold the current state */
	reg state_t current_state;
	
	/* Register to hold the received data byte */
	reg [7:0] received_byte;
	
	/* Register to count the bits received */
	reg [2:0] bit_counter;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			received_byte <= 8'b0;
			bit_counter <= 3'b0;
		end else begin
			case (current_state)
				IDLE: begin
					if (in == 1'b0) begin
						current_state <= START_BIT;
						bit_counter <= 3'b0;
						received_byte <= 8'b0;
					end
				end
				START_BIT: begin
					if (bit_counter < 3) begin
						bit_counter <= bit_counter + 1;
					end else if (bit_counter == 3) begin
						if (in == 1'b0) begin
							current_state <= DATA_BIT;
							bit_counter <= 3'b0;
						end else begin
							current_state <= IDLE;
							bit_counter <= 3'b0;
						end
					end
				end
				DATA_BIT: begin
					if (bit_counter < 8) begin
						received_byte <= {in, received_byte[7:1]};
						bit_counter <= bit_counter + 1;
					end else if (bit_counter == 8) begin
						current_state <= STOP_BIT;
					end
				end
				STOP_BIT: begin
					if (bit_counter < 9) begin
						if (bit_counter == 8 && in == 1'b1) begin
							done <= 1;
							out_byte <= received_byte;
						end else if (bit_counter < 8 && in == 1'b0) begin
							current_state <= IDLE;
						end
						bit_counter <= bit_counter + 1;
					end else begin
						current_state <= IDLE;
					end
				end
				default: current_state <= IDLE;
			endcase
		end
	end	
endmodule
