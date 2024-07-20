module top_module(
	input clk,
	input reset,
	output shift_ena);

	// state declaration
	reg [1:0] state;
	parameter [1:0] IDLE = 2'b00;
	parameter [1:0] RESET = 2'b01;
	parameter [1:0] ENABLE = 2'b10;
	
	// shift register counter
	reg [3:0] count;
	wire [3:0] shift_ena_pulse;
	
	// next state and count
	reg [1:0] next_state;
	reg [3:0] next_count;

	// state and count assignments
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= RESET;
			count <= 4'b0;
		end else begin
			state <= next_state;
			count <= next_count;
		end
	end
	
	// next state logic
	always @(state, count) begin
		case (state)
			RESET: begin
				if (count < 4) begin
					next_state = RESET;
					next_count = count + 1;
				end else begin
					next_state = IDLE;
					next_count = 4'b0;
				end
			end
			
			IDLE: begin
				if (/* Your bit pattern detection condition here */) begin
					next_state = ENABLE;
					next_count = 4'b0;
				end else begin
					next_state = IDLE;
					next_count = 4'b0;
				end
			end
			
			ENABLE: begin
				if (count < 4) begin
					next_state = ENABLE;
					next_count = count + 1;
				end else begin
					next_state = IDLE;
					next_count = 4'b0;
				end
			end
		endcase
	end
	
	// shift enable pulse generator
	assign shift_ena_pulse = ((state == ENABLE) & (count < 4)) ? 4'b1 : 4'b0;
	
	// shift enable output
	assign shift_ena = shift_ena_pulse[0];

endmodule
