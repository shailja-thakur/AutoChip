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
    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALL_LEFT = 2'b10,
        FALL_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic (combinational)
    always_comb begin
        case(state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_left || bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            default: next_state = LEFT; // Default state
        endcase
    end

    // Output logic (combinational)
    always_comb begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case(state)
            LEFT: begin
                walk_left = 1;
            end
            RIGHT: begin
                walk_right = 1;
            end
            FALL_LEFT: begin
                aaah = 1;
            end
            FALL_RIGHT: begin
                aaah = 1;
            end
        endcase
    end

endmodule
