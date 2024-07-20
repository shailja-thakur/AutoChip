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

    // Define states
    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        FALL = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end

            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end

            default: next_state = state;
        endcase
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            
            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            
            FALL_LEFT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
            
            FALL_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
