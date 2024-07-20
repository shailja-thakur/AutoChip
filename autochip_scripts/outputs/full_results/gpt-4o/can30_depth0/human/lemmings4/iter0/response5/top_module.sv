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

    reg [3:0] state, next_state;
    reg [4:0] fall_counter;

    // State encoding
    localparam LEFT = 4'd0, RIGHT = 4'd1, FALL_LEFT = 4'd2, FALL_RIGHT = 4'd3,
               DIG_LEFT = 4'd4, DIG_RIGHT = 4'd5, SPLATTER = 4'd6;

    // State transition logic
    always @(*) begin
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
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = (fall_counter > 5'd20) ? SPLATTER : LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = (fall_counter > 5'd20) ? SPLATTER : RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = LEFT;
        endcase
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

    // Fall counter logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            fall_counter <= 5'd0;
        end else if (state == FALL_LEFT || state == FALL_RIGHT) begin
            fall_counter <= fall_counter + 5'd1;
        end else begin
            fall_counter <= 5'd0;
        end
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end
endmodule
