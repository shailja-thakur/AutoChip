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

// Define states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL
} State;

// Define signals
reg [1:0] current_state;
reg [1:0] next_state;
reg walk_left;
reg walk_right;
reg aaah;

// Define state transitions and outputs
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT; // Initial state
    end else begin
        current_state <= next_state;
    end
end

always @* begin
    case(current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALL;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALL;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        FALL: begin
            if (ground) begin
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (current_state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end
            end else begin
                next_state = FALL;
            end
        end
        default: next_state = WALK_LEFT;
    endcase
end

// Define outputs based on current state
always @(current_state) begin
    case(current_state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
        end
        default: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
    endcase
end

endmodule
