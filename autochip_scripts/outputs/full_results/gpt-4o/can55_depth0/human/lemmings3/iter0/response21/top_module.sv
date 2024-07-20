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
    typedef enum reg [2:0] {
        LEFT = 3'b000, 
        RIGHT = 3'b001, 
        FALL_L = 3'b010, 
        FALL_R = 3'b011, 
        DIG_L = 3'b100, 
        DIG_R = 3'b101
    } state_type;
    
    state_type state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            LEFT: begin
                if (!ground) 
                    next_state = FALL_L; 
                else if (dig) 
                    next_state = DIG_L; 
                else if (bump_left || bump_right) 
                    next_state = RIGHT; 
                else 
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) 
                    next_state = FALL_R; 
                else if (dig) 
                    next_state = DIG_R; 
                else if (bump_left || bump_right) 
                    next_state = LEFT; 
                else 
                    next_state = RIGHT;
            end
            FALL_L: begin
                if (ground) 
                    next_state = LEFT; 
                else 
                    next_state = FALL_L;
            end
            FALL_R: begin
                if (ground) 
                    next_state = RIGHT; 
                else 
                    next_state = FALL_R;
            end
            DIG_L: begin
                if (!ground) 
                    next_state = FALL_L; 
                else 
                    next_state = DIG_L;
            end
            DIG_R: begin
                if (!ground) 
                    next_state = FALL_R; 
                else 
                    next_state = DIG_R;
            end
            default: next_state = LEFT;
        endcase
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L) | (state == FALL_R);
    assign digging = (state == DIG_L) | (state == DIG_R);

endmodule
