module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

    // Define states
    typedef enum reg [2:0] {
        WL = 3'b000,  // Walking Left
        WR = 3'b001,  // Walking Right
        FL = 3'b010,  // Falling while last walking Left
        FR = 3'b011,  // Falling while last walking Right
        A  = 3'b100   // Aaah! State for falling
    } state_t;
	
	state_t state, next_state;
	
	always @(*) begin
		case (state)
			WL: next_state = ground ? (bump_left ? WR : WL) : FL;
			WR: next_state = ground ? (bump_right ? WL : WR) : FR;
			FL: next_state = ground ? WL : FL;
			FR: next_state = ground ? WR : FR;
			default: next_state = FL;  // Default to falling in case of unknown state
		endcase
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			WL: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			WR: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			FL, FR: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
			end
		endcase
	end

endmodule
