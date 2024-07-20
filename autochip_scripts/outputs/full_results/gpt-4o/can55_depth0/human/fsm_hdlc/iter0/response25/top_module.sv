module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [2:0] state, next_state;
	
	localparam IDLE      = 3'b000;
	localparam ONE       = 3'b001;
	localparam TWO       = 3'b010;
	localparam THREE     = 3'b011;
	localparam FOUR      = 3'b100;
	localparam FIVE      = 3'b101;
	localparam SIX       = 3'b110;
	localparam SEVEN     = 3'b111;
	
	// State transitions
	always @(*) begin
		case (state)
			IDLE: begin
				if (in) next_state = ONE;
				else   next_state = IDLE;
			end
			ONE: begin
				if (in) next_state = TWO;
				else   next_state = IDLE;
			end
			TWO: begin
				if (in) next_state = THREE;
				else   next_state = IDLE;
			end
			THREE: begin
				if (in) next_state = FOUR;
				else   next_state = IDLE;
			end
			FOUR: begin
				if (in) next_state = FIVE;
				else   next_state = IDLE;
			end
			FIVE: begin
				if (in) next_state = SIX;
				else   next_state = IDLE;
			end
			SIX: begin
				if (in) next_state = SEVEN;
				else   next_state = ONE; // For the sequence '0111110'
			end
			SEVEN: begin
				if (in) next_state = SEVEN; // Remain in error state
				else   next_state = IDLE; // For the sequence '01111111'
			end
			default: next_state = IDLE;
		endcase
	end
	
	// State flip-flops
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end
		else begin
			disc <= 1'b0;
			flag <= 1'b0;
			err  <= 1'b0;
			
			case (state)
				SIX: if (next_state == ONE) disc <= 1'b1; // Detect '0111110'
				SIX: if (next_state == SEVEN && in == 1'b1) flag <= 1'b1; // Detect '01111110'
				SEVEN: if (in == 1'b1) err <= 1'b1; // Detect '01111111...'
			endcase
		end
	end

endmodule
