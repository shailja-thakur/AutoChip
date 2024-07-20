module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

// Define states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
} state_t;

// Define state register and next state variables
reg state_t state_reg;
reg state_t state_next;

// Define internal signals
wire do_fall;
wire do_dig;

// Initialize state register on reset
always @(posedge areset) begin
    state_reg <= WALK_LEFT;
end

// Clock always block
always @(posedge clk) begin
    // Update state register with next state value
    state_reg <= state_next;
end

// Combinational logic
always @* begin
    // Default values
    state_next = state_reg;
    do_fall = 0;
    do_dig = 0;
    
    // State transitions
    case (state_reg)
        WALK_LEFT:
            if (bump_right)
                state_next = WALK_RIGHT;
            else if (ground == 0)
                state_next = FALL;
        WALK_RIGHT:
            if (bump_left)
                state_next = WALK_LEFT;
            else if (ground == 0)
                state_next = FALL;
        FALL:
            if (ground)
                state_next = state_reg == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
        DIG:
            if (ground == 0)
                state_next = FALL;
    endcase
    
    // Additional conditions
    if (ground == 0 && dig == 1)
        do_dig = 1;
    else if (ground == 1 && state_reg == DIG)
        do_fall = 1;
end

// Output assignments
assign walk_left = (state_reg == WALK_LEFT) ? 1 : 0;
assign walk_right = (state_reg == WALK_RIGHT) ? 1 : 0;
assign aaah = (state_reg == FALL) ? 1 : 0;
assign digging = (state_reg == DIG) ? 1 : 0;

endmodule
