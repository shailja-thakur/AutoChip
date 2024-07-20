module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);
// Define state enum
typedef enum logic [1:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT,
    STATE_FALL
} state_t;

// Define state register and next state
reg state_t current_state;
reg state_t next_state;

// Define outputs
assign walk_left = (current_state == STATE_WALK_LEFT);
assign walk_right = (current_state == STATE_WALK_RIGHT);
assign aaah = (current_state == STATE_FALL);

// Define state transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

// Define state logic
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT:
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end else begin
                next_state = STATE_WALK_LEFT;
            end
        STATE_WALK_RIGHT:
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end else begin
                next_state = STATE_WALK_RIGHT;
            end
        STATE_FALL:
            if (ground) begin
                if (current_state == STATE_WALK_LEFT) begin
                    next_state = STATE_WALK_LEFT;
                end else if (current_state == STATE_WALK_RIGHT) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end else begin
                next_state = STATE_FALL;
            end
    endcase
end

endmodule
