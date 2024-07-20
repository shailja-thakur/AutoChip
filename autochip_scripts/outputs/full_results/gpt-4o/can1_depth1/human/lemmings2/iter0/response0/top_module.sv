module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    typedef enum reg [2:0] {
        LEFT       = 3'b001,
        RIGHT      = 3'b010,
        FALL_LEFT  = 3'b011,
        FALL_RIGHT = 3'b100
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
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left || bump_right)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            
            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_left || bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            
            FALL_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT;
            end
            
            FALL_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
            
            default: next_state = LEFT;
        endcase
    end

    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (state)
            LEFT: begin
                walk_left = 1;
            end
            
            RIGHT: begin
                walk_right = 1;
            end
            
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1;
            end
        endcase
    end

endmodule
