module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);
	
	reg [3:0] state, next_state;
	
	localparam IDLE = 4'd0,
			   S1 = 4'd1,
			   S2 = 4'd2,
			   S3 = 4'd3,
			   S4 = 4'd4,
			   S5 = 4'd5,
			   DISCARD = 4'd6,
			   FLAG = 4'd7,
			   ERROR = 4'd8;
	
	always @ (posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	always @(*) begin
		next_state = state;
		case (state)
			IDLE: begin
				disc = 0;
				flag = 0;
				err = 0;
				if (in)
					next_state = S1;
				else
					next_state = IDLE;
			end
			
			S1: begin
				disc = 0;
				flag = 0;
				err = 0;
				if (~in)
					next_state = S2;
				else
					next_state = S1;
			end

			S2: begin
				disc = 0;
				flag = 0;
				err = 0;
				if (in)
					next_state = S3;
				else
					next_state = IDLE;
			end

			S3: begin
				disc = 0;
				flag = 0;
				err = 0;
				if (in)
					next_state = S4;
				else
					next_state = IDLE;
			end

			S4: begin
				disc = 0;
				flag = 0;
				err = 0;
				if (in)
					next_state = S5;
				else
					next_state = IDLE;
			end

			S5: begin
				disc = 0;
				flag = 0;
				err = 0;
				if (in)
					next_state = DISCARD;
				else
					next_state = IDLE;
			end

			DISCARD: begin
				disc = 1;
				flag = 0;
				err = 0;
				if (in)
					next_state = FLAG;
				else
					next_state = S2;
			end
			
			FLAG: begin
				disc = 0;
				flag = 1;
				err = 0;
				if (in)
					next_state = ERROR;
				else
					next_state = IDLE;
			end
			
			ERROR: begin
				disc = 0;
				flag = 0;
				err = 1;
				if (~reset)
					next_state = ERROR;
				else
					next_state = IDLE;
			end
			
			default: begin
				disc = 0;
				flag = 0;
				err = 0;
				next_state = IDLE;
			end
		endcase
	end
	
endmodule
