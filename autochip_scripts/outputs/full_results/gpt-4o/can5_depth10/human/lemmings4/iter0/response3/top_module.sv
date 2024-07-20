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

    typedef enum {WALK_LEFT, WALK_RIGHT, FALLING_LEFT, FALLING_RIGHT, DIGGING_LEFT, DIGGING_RIGHT, SPLATTERED} state_t;
    state_t state, next_state;

    reg [4:0] fall_counter;

    // State transitions
    always @(*) begin
        case(state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALLING_LEFT, FALLING_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTERED;
                    else if (state == FALLING_LEFT)
                        next_state = WALK_LEFT;
                    else
                        next_state = WALK_RIGHT;
                end
                else
                    next_state = state;
            end
            DIGGING_LEFT, DIGGING_RIGHT: begin
                if (!ground) begin
                    if (state == DIGGING_LEFT)
                        next_state = FALLING_LEFT;
                    else
                        next_state = FALLING_RIGHT;
                end
                else
                    next_state = state;
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
            default: next_state = WALK_LEFT; // Default to a known state
        endcase
    end

    // State update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Fall counter management
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            fall_counter <= 0;
        end
        else if (state == FALLING_LEFT || state == FALLING_RIGHT) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALLING_LEFT || state == FALLING_RIGHT);
        digging = (state == DIGGING_LEFT || state == DIGGING_RIGHT);
    end
endmodule
