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

    reg [4:0] state;
    reg [4:0] next_state;

    parameter WALK_LEFT = 0;
    parameter WALK_RIGHT = 1;
    parameter FALL = 2;
    parameter DIG = 3;
    parameter SPLATTER = 4;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            state <= next_state;
            case(state)
                WALK_LEFT: begin
                    if (bump_right)
                        next_state = WALK_RIGHT;
                    else if (!ground)
                        next_state = FALL;
                    else if (dig && ground)
                        next_state = DIG;
                    else
                        next_state = WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                WALK_RIGHT: begin
                    if (bump_left)
                        next_state = WALK_LEFT;
                    else if (!ground)
                        next_state = FALL;
                    else if (dig && ground)
                        next_state = DIG;
                    else
                        next_state = WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end
                FALL: begin
                    if (!ground)
                        next_state = FALL;
                    else if (state != FALL)
                        next_state = walk_left ? WALK_LEFT : WALK_RIGHT;
                    else if (!bump_left && !bump_right)
                        next_state = walk_left ? WALK_LEFT : WALK_RIGHT;
                    else if (dig && ground)
                        next_state = DIG;
                    else
                        next_state = SPLATTER;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                DIG: begin
                    if (!ground)
                        next_state = FALL;
                    else if (state != DIG)
                        next_state = walk_left ? WALK_LEFT : WALK_RIGHT;
                    else if (!bump_left && !bump_right && ground)
                        next_state = walk_left ? WALK_LEFT : WALK_RIGHT;
                    else
                        next_state = SPLATTER;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                SPLATTER: begin
                    next_state = SPLATTER;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
        end
    end

endmodule
