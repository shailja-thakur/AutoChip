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

    typedef enum logic [2:0] {
        LEFT = 3'b001, // Walking left
        RIGHT = 3'b010, // Walking right
        FALL_LEFT = 3'b011, // Falling when was walking left
        FALL_RIGHT = 3'b100 // Falling when was walking right
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT; // Reset to walking left
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (state)
            LEFT: begin
                walk_left = 1;
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left || (bump_left && bump_right)) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end

            RIGHT: begin
                walk_right = 1;
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_right || (bump_left && bump_right)) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end

            FALL_LEFT: begin
                aaah = 1;
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end

            FALL_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end

            default: next_state = LEFT; // Safety default state
        endcase
    end
endmodule
