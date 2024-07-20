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
    reg [3:0] state, next_state;
    reg [4:0] fall_count;
    
    typedef enum reg [3:0] {
        S_WALK_LEFT = 4'd0,
        S_WALK_RIGHT = 4'd1,
        S_FALL_LEFT = 4'd2,
        S_FALL_RIGHT = 4'd3,
        S_DIG_LEFT = 4'd4,
        S_DIG_RIGHT = 4'd5,
        S_SPLATTER = 4'd6
    } state_t;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (aaah)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else if (dig)
                    next_state = S_DIG_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_WALK_LEFT;
            end
            
            S_WALK_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else if (dig)
                    next_state = S_DIG_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
            end
            
            S_FALL_LEFT: begin
                if (ground && fall_count > 20)
                    next_state = S_SPLATTER;
                else if (ground)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_FALL_LEFT;
            end
            
            S_FALL_RIGHT: begin
                if (ground && fall_count > 20)
                    next_state = S_SPLATTER;
                else if (ground)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_FALL_RIGHT;
            end
            
            S_DIG_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else
                    next_state = S_DIG_LEFT;
            end
            
            S_DIG_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else
                    next_state = S_DIG_RIGHT;
            end
            
            S_SPLATTER: next_state = S_SPLATTER;
            default: next_state = S_WALK_LEFT;
        endcase
    end

    always @(*) begin
        walk_left = (state == S_WALK_LEFT);
        walk_right = (state == S_WALK_RIGHT);
        aaah = (state == S_FALL_LEFT || state == S_FALL_RIGHT);
        digging = (state == S_DIG_LEFT || state == S_DIG_RIGHT);
    end
endmodule
