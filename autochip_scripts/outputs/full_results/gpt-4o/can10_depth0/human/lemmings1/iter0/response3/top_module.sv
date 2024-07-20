module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State declarations
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end

            WALK_RIGHT: begin
                if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end

            default: next_state = WALK_LEFT;  // Safe default state
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
        end else begin
            case (next_state)
                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                end

                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                end

                default: begin
                    walk_left <= 1;
                    walk_right <= 0;
                end
            endcase
        end
    end

endmodule
