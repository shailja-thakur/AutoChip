module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [2:0] state, next_state;
	reg [7:0] data;
	reg stop_bit;
	parameter IDLE = 3'b000, START_BIT = 3'b001, DATA_BITS = 3'b010, STOP_BIT = 3'b011;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	always @(state or in) begin
		case (state)
			IDLE: begin
				data <= 8'b0;
				stop_bit <= 1'b1;
				if (in == 1'b0)
					next_state <= START_BIT;
				else
					next_state <= IDLE;
			end
			
			START_BIT: begin
				if (in == 1'b0)
					next_state <= DATA_BITS;
				else
					next_state <= START_BIT;
			end
			
			DATA_BITS: begin
				data <= {data[6:0], in};
				if (data[7] == 1'b1)
					next_state <= STOP_BIT;
				else
					next_state <= DATA_BITS;
			end
			
			STOP_BIT: begin
				if (in == 1'b1)
					next_state <= IDLE;
				else
					next_state <= STOP_BIT;
			end
		endcase
	end
	
	assign done = (state == IDLE);
	
endmodule
