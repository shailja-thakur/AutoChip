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
    
    typedef enum logic [1:0] {
        LEFT    = 2'b00,
        RIGHT   = 2'b01,
        FALLING = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg last_direction; // 0 for left, 1 for right

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            last_direction <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALLING: begin
                if (ground)
                    next_state = (last_direction ? RIGHT : LEFT);
                else
                    next_state = FALLING;
            end
            default: next_state = LEFT;
        endcase
    end

    always @(*) begin
        // Outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        
        case (state)
            LEFT: begin
                walk_left = 1;
                last_direction = 0;
            end
            RIGHT: begin
                walk_right = 1;
                last_direction = 1;
            end
            FALLING: begin
                aaah = 1;
            end
        endcase
    end

endmodule
