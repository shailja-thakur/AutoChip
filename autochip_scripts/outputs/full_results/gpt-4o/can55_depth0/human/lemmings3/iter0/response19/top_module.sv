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

    typedef enum reg [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground) next_state = LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) next_state = RIGHT;
                else next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            default: next_state = LEFT; // default state
        endcase
    end

    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
        digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
    end

endmodule
