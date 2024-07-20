module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    reg [2:0] state, next_state;
    reg [4:0] fall_count; // 5-bit register to count up to 20
    parameter LEFT = 3'b000, RIGHT = 3'b001, FALL_LEFT = 3'b010, FALL_RIGHT = 3'b011, DIG_LEFT = 3'b100, DIG_RIGHT = 3'b101, SPLATTER = 3'b110;

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = RIGHT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = LEFT;
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else if (state == FALL_LEFT)
                        next_state = LEFT;
                    else
                        next_state = RIGHT;
                end
            end
            DIG_LEFT, DIG_RIGHT: begin
                if (!ground) begin
                    next_state = (state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER; // Remain in splatter state
            end
        endcase
    end

    // State FFs and reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT || state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT || state == DIG_RIGHT);

endmodule
