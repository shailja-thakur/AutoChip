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

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        WALK_LEFT = 3'b001,
        WALK_RIGHT = 3'b010,
        FALLING_LEFT = 3'b011,
        FALLING_RIGHT = 3'b100,
        DIGGING_LEFT = 3'b101,
        DIGGING_RIGHT = 3'b110,
        SPLATTERED = 3'b111
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_count;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == FALLING_LEFT || state == FALLING_RIGHT) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 0;
            end
        end
    end

    always_comb begin
        next_state = state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                walk_right = 1;
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end
            FALLING_LEFT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = WALK_LEFT;
                end
            end
            FALLING_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = WALK_RIGHT;
                end
            end
            DIGGING_LEFT: begin
                digging = 1;
                if (!ground)
                    next_state = FALLING_LEFT;
            end
            DIGGING_RIGHT: begin
                digging = 1;
                if (!ground)
                    next_state = FALLING_RIGHT;
            end
            SPLATTERED: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            default: next_state = WALK_LEFT;
        endcase
    end
endmodule
