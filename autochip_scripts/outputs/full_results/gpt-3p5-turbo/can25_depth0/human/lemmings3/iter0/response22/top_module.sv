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

// Enumerated states for the finite state machine
typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
} state_t;

reg [2:0] state, next_state;

// Sequential logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always @(state, bump_left, bump_right, ground, dig) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            next_state = WALK_LEFT;
            if (bump_left) begin
                next_state = WALK_RIGHT;
            end else if (bump_right) begin
                next_state = WALK_LEFT;
            end else if (ground == 0) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end
        end
        
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            next_state = WALK_RIGHT;
            if (bump_left) begin
                next_state = WALK_RIGHT;
            end else if (bump_right) begin
                next_state = WALK_LEFT;
            end else if (ground == 0) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end
        end
        
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            next_state = FALL;
            if (ground) begin
                next_state = state;
                aaah = 0;
            end
        end
        
        DIG: begin
            walk_left = 0;
            walk_right = 0;
            next_state = DIG;
            if (ground == 0) begin
                next_state = FALL;
            end
        end
        
        default: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
