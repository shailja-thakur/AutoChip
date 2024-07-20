module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [3:0] state, next_state;

	localparam [3:0]
		IDLE       = 4'd0,
		BIT_0      = 4'd1,
		BIT_01     = 4'd2,
		BIT_011    = 4'd3,
		BIT_0111   = 4'd4,
		BIT_01111  = 4'd5,
		BIT_011111 = 4'd6,
		BIT_0111110= 4'd7,
		BIT_0111111= 4'd8,
		ERROR      = 4'd9;

	// State transition
	always @ (posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always @ (*) begin
		next_state = state;
		case (state)
			IDLE: begin
				if (in == 1'b0) next_state = BIT_0;
				// implicitly stays in IDLE if (in == 1'b1)
			end

			BIT_0: begin
				if (in == 1'b1) next_state = BIT_01;
				else next_state = BIT_0;
			end

			BIT_01: begin
				if (in == 1'b1) next_state = BIT_011;
				else next_state = BIT_0;
			end

			BIT_011: begin
				if (in == 1'b1) next_state = BIT_0111;
				else next_state = BIT_0;
			end

			BIT_0111: begin
				if (in == 1'b1) next_state = BIT_01111;
				else next_state = BIT_0;
			end

			BIT_01111: begin
				if (in == 1'b1) next_state = BIT_011111;
				else next_state = BIT_0;
			end

			BIT_011111: begin
				if (in == 1'b0) next_state = BIT_0111110;
				else next_state = BIT_0111111;
			end

			BIT_0111110: begin
				if (in == 1'b0) next_state = BIT_0;
				else next_state = BIT_01;
			end
			
			BIT_0111111: begin
				if (in == 1'b1) next_state = ERROR;
				else next_state = BIT_0;
			end
			
			ERROR: begin
				if (in == 1'b0) next_state = BIT_0;
				// implicitly stays in ERROR if (in == 1'b1)
			end

			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @ (posedge clk) begin
		if (reset) begin
			disc <= 1'b0;
			flag <= 1'b0;
			err  <= 1'b0;
		end
		else begin
			disc <= 1'b0;
			flag <= 1'b0;
			err  <= 1'b0;
			case (next_state)
				BIT_0111110: disc <= 1'b1;
				BIT_0111111: flag <= 1'b1;
				ERROR: err <= 1'b1;
			endcase
		end
	end

endmodule
