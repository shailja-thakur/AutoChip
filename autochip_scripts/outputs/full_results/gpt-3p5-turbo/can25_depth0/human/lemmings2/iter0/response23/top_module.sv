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

// Define the states
typedef enum logic [1:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT,
    STATE_FALL
} state_t;

// Define the signals
reg [1:0] state; // current state
reg [1:0] next_state; // next state

// Define the outputs
reg walk_left;
reg walk_right;
reg aaah;

// Define the state transitions
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT; // Initialize state to walking left
        walk_left <= 1; // Initial output is walking left
        walk_right <= 0;
        aaah <= 0;
    end else begin
        state <= next_state;
        case (state)
            STATE_WALK_LEFT: begin
                if (bump_right) begin
                    next_state <= STATE_WALK_RIGHT; // Switch to walking right if bumped on the right
                end else if (ground == 0) begin
                    next_state <= STATE_FALL; // Fall if ground disappears
                end else begin
                    next_state <= STATE_WALK_LEFT; // Keep walking left
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_left) begin
                    next_state <= STATE_WALK_LEFT; // Switch to walking left if bumped on the left
                end else if (ground == 0) begin
                    next_state <= STATE_FALL; // Fall if ground disappears
                end else begin
                    next_state <= STATE_WALK_RIGHT; // Keep walking right
                end
            end
            STATE_FALL: begin
                if (ground) begin
                    next_state <= state; // Revert to the previous state if ground reappears
                end else begin
                    next_state <= STATE_FALL; // Keep falling
                end
            end
        endcase
    end
end

// Define the outputs based on the current state
always_comb begin
    case (state)
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
    endcase
end

endmodule
