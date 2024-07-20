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
        LEFT = 3'd0,
        RIGHT = 3'd1,
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3,
        DIG_LEFT = 3'd4,
        DIG_RIGHT = 3'd5,
        SPLATTERED = 3'd6
    } state_t;
    
    state_t state, next_state;
    reg [4:0] fall_count;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 5'd0;
        end else begin
            state <= next_state;
            if ((state == FALL_LEFT || state == FALL_RIGHT) && ground == 0)
                fall_count <= fall_count + 1;
            else if (ground == 1)
                fall_count <= 5'd0;
        end
    end

    always_comb begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
                walk_left = 1;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
                walk_right = 1;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = LEFT;
                end else
                    next_state = FALL_LEFT;
                aaah = 1;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTERED;
                    else
                        next_state = RIGHT;
                end else
                    next_state = FALL_RIGHT;
                aaah = 1;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
                digging = 1;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
                digging = 1;
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

endmodule
