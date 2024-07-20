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
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALLING_LEFT = 2'b10,
        FALLING_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            LEFT: begin
                if (!ground) 
                    next_state = FALLING_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALLING_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALLING_RIGHT;
            end
        endcase
    end

    always_comb begin
        case (current_state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            FALLING_LEFT, FALLING_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
