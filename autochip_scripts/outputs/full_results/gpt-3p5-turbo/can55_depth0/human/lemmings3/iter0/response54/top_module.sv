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

// Define states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
} state_t;

// Define current state
reg state_t current_state;

// Define next state
reg state_t next_state;

// Set initial state to walk_left
initial begin
    current_state = WALK_LEFT;
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

always @* begin
    case (current_state)
        WALK_LEFT:
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end else begin
                next_state = WALK_LEFT;
            end
        
        WALK_RIGHT:
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end else begin
                next_state = WALK_RIGHT;
            end
        
        FALL:
            if (ground) begin
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end else begin
                next_state = FALL;
            end
        
        DIG:
            if (ground) begin
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end else if (!ground && !dig) begin
                next_state = FALL;
            end else begin
                next_state = DIG;
            end
    endcase
end

always @(current_state) begin
    case (current_state)
        WALK_LEFT:
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        
        WALK_RIGHT:
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        
        FALL:
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        
        DIG:
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
    endcase
end

endmodule
