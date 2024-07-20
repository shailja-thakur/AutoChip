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

    // State Declaration
    typedef enum reg [3:0] {
        LEFT_WALK = 4'b0001,
        RIGHT_WALK = 4'b0010,
        FALL_LEFT = 4'b0100,
        FALL_RIGHT = 4'b1000,
        DIG_LEFT = 4'b0011,
        DIG_RIGHT = 4'b0110,
        SPLATTERED = 4'b1111
    } state_t;

    reg [4:0] fall_count;
    reg [3:0] state, next_state;

    // State Transitions & Output Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT_WALK;
            fall_count <= 0;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            state <= next_state;
            if (aaah)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;

            if (next_state == FALL_LEFT || next_state == FALL_RIGHT) begin
                aaah <= 1;
            end else begin
                aaah <= 0;
            end

            case (next_state)
                LEFT_WALK: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    digging <= 0;
                end
                RIGHT_WALK: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    digging <= 0;
                end
                DIG_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    digging <= 1;
                end
                DIG_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    digging <= 1;
                end
                FALL_LEFT, FALL_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    digging <= 0;
                end
                SPLATTERED: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    digging <= 0;
                    aaah <= 0;
                end
            endcase
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = state;
        case (state)
            LEFT_WALK: begin
                if (ground == 0)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = RIGHT_WALK;
            end
            RIGHT_WALK: begin
                if (ground == 0)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = LEFT_WALK;
            end
            DIG_LEFT: begin
                if (ground == 0)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (ground == 0)
                    next_state = FALL_RIGHT;
            end
            FALL_LEFT: begin
                if (ground == 1) begin
                    if (fall_count > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = LEFT_WALK;
                end
            end
            FALL_RIGHT: begin
                if (ground == 1) begin
                    if (fall_count > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = RIGHT_WALK;
                end
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
        endcase
    end
endmodule
