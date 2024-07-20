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

// State definition
typedef enum logic [1:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT,
    STATE_FALL,
    STATE_RESUME_WALK
} state_t;

// Registers
reg state_t current_state;
reg walk_left;
reg walk_right;
reg aaah;

// Next-state logic
always_ff @(posedge clk or posedge areset) begin
    if (areset == 1) begin
        current_state <= STATE_WALK_LEFT;
    end else begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (bump_right) begin
                    current_state <= STATE_WALK_RIGHT;
                end else if (!ground) begin
                    current_state <= STATE_FALL;
                end else begin
                    current_state <= STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_left) begin
                    current_state <= STATE_WALK_LEFT;
                end else if (!ground) begin
                    current_state <= STATE_FALL;
                end else begin
                    current_state <= STATE_WALK_RIGHT;
                end
            end
            STATE_FALL: begin
                if (ground) begin
                    current_state <= STATE_RESUME_WALK;
                end else begin
                    current_state <= STATE_FALL;
                end
            end
            STATE_RESUME_WALK: begin
                if (!ground) begin
                    current_state <= STATE_FALL;
                end else if (bump_left) begin
                    current_state <= STATE_WALK_LEFT;
                end else if (bump_right) begin
                    current_state <= STATE_WALK_RIGHT;
                end else begin
                    current_state <= STATE_RESUME_WALK;
                end
            end
        endcase
    end
end

// Output logic
always_comb begin
    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
        end
        STATE_FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
        end
        STATE_RESUME_WALK: begin
            walk_left = walk_left;
            walk_right = walk_right;
            aaah = 0;
        end
    endcase
end

endmodule
