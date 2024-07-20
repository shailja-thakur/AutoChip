module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state_reg, state_next;

parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= IDLE;
	end else begin
		state_reg <= state_next;
	end
end

always @* begin
	state_next = state_reg;
	
	case (state_reg)
		IDLE: begin
			if (in == 1'b0) begin
				state_next = START_BIT;
			end
		end
		
		START_BIT: begin
			state_next = DATA_BITS;
		end
		
		DATA_BITS: begin
			if (in == 1'b1) begin
				state_next = STOP_BIT;
			end
		end
		
		STOP_BIT: begin
			if (in == 1'b1) begin
				state_next = IDLE;
			end
		end
	endcase
end

assign done = (state_reg == IDLE);

endmodule
