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

// Define the states
typedef enum {WALK_LEFT, WALK_RIGHT, FALL, DIG} state_t;
state_t state, next_state;

// Define the state register
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig && ground) begin
                next_state = DIG;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig && ground) begin
                next_state = DIG;
            end
        end
        FALL: begin
            if (ground) begin
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
        DIG: begin
            if (!ground) begin
                next_state = FALL;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
        end
        WALK_RIGHT: begin
            walk_right = 1;
        end
        FALL: begin
            aaah = 1;
        end
        DIG: begin
            digging = 1;
        end
    endcase
end

endmodule
