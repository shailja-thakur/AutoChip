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
    
    localparam  WALK_LEFT = 4'd0,
                WALK_RIGHT = 4'd1,
                FALL = 4'd2,
                DIG_LEFT = 4'd3,
                DIG_RIGHT = 4'd4,
                SPLATTER = 4'd5;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALL)
                fall_counter <= fall_counter + 5'd1;
            else if (state != FALL)
                fall_counter <= 5'd0;
        end
    end
    
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL: begin
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = SPLATTER;
                    else if (state == WALK_LEFT || state == DIG_LEFT)
                        next_state = WALK_LEFT;
                    else if (state == WALK_RIGHT || state == DIG_RIGHT)
                        next_state = WALK_RIGHT;
                end else
                    next_state = FALL;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else
                    next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG_LEFT || state == DIG_RIGHT);

endmodule
