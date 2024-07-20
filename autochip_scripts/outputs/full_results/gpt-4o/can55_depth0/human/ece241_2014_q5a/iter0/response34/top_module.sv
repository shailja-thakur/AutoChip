module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg [1:0] state, next_state;

	// States
	parameter IDLE = 2'b00;
	parameter INVERT = 2'b01;
	parameter ADD_ONE = 2'b10;
	
	// State transitions
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
			z <= 0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @ (*) begin
		case (state)
			IDLE: begin
				if (x == 1) begin
					next_state = INVERT;
				end else begin
					next_state = IDLE;
				end
			end
			INVERT: begin
				next_state = ADD_ONE;
			end
			ADD_ONE: begin
				next_state = INVERT;
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

	// Output logic
	always @ (*) begin
		case (state)
			IDLE: begin
				z = 0;
			end
			INVERT: begin
				z = ~x;
			end
			ADD_ONE: begin
				if (x == 0) begin
					z = 1;
				end else begin
					z = 0;
				end				
			end
			default: begin
				z = 0;
			end
		endcase
	end

endmodule
