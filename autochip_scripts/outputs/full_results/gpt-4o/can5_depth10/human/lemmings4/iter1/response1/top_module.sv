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

    // State declarations
    typedef enum {LEFT, RIGHT, FALLING, DIGGING_LEFT, DIGGING_RIGHT, SPLAT} state_t;
    state_t state, next_state;
    reg [4:0] fall_counter;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALLING;
                else if (dig) next_state = DIGGING_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALLING;
                else if (dig) next_state = DIGGING_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALLING: begin
                if (ground && fall_counter > 20) next_state = SPLAT;
                else if (ground) next_state = (state == DIGGING_LEFT || state == LEFT) ? LEFT : RIGHT;
                else next_state = FALLING;
            end
            DIGGING_LEFT: begin
                if (!ground) next_state = FALLING;
                else next_state = DIGGING_LEFT;
            end
            DIGGING_RIGHT: begin
                if (!ground) next_state = FALLING;
                else next_state = DIGGING_RIGHT;
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

    // State flip-flops and fall counter update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == FALLING) begin
                fall_counter <= fall_counter + 1;
            end else if (ground) begin
                fall_counter <= 0;
            end
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALLING: aaah = 1;
            DIGGING_LEFT: digging = 1;
            DIGGING_RIGHT: digging = 1;
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
