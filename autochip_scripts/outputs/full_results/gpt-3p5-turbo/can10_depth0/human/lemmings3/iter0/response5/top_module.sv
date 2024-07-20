module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

// State declaration
typedef enum logic [1:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT,
    STATE_FALL,
    STATE_DIG
} state_t;

// Register declarations
reg [1:0] state_reg;
reg [1:0] next_state_reg;

// Moore outputs
always @(state_reg) begin
    case(state_reg)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        STATE_FALL: begin
            walk_left = state_reg == STATE_WALK_LEFT;
            walk_right = state_reg == STATE_WALK_RIGHT;
            aaah = 1;
            digging = 0;
        end
        STATE_DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
    endcase
end

// Next state logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state_reg <= STATE_WALK_LEFT;
    end else begin
        state_reg <= next_state_reg;
    end
end

// State transition logic
always @* begin
    next_state_reg = state_reg;
    case(state_reg)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state_reg = STATE_WALK_RIGHT;
            end else if (bump_left && !bump_right) begin
                next_state_reg = STATE_WALK_LEFT;
            end else if (!bump_left && !bump_right && !ground) begin
                next_state_reg = STATE_FALL;
            end else if (!bump_left && !bump_right && ground && dig) begin
                next_state_reg = STATE_DIG;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state_reg = STATE_WALK_LEFT;
            end else if (bump_right && !bump_left) begin
                next_state_reg = STATE_WALK_RIGHT;
            end else if (!bump_left && !bump_right && !ground) begin
                next_state_reg = STATE_FALL;
            end else if (!bump_left && !bump_right && ground && dig) begin
                next_state_reg = STATE_DIG;
            end
        end
        STATE_FALL: begin
            if (ground) begin
                next_state_reg = walk_left ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
        STATE_DIG: begin
            if (!ground) begin
                next_state_reg = STATE_FALL;
            end
        end
    endcase
end

endmodule
