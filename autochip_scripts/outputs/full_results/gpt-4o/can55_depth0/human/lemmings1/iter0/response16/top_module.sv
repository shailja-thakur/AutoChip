module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    // State encoding
    typedef enum logic [1:0] {
        LEFT = 2'b01,
        RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT; // On areset, go to walk_left state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            default: begin
                next_state = LEFT; // Default state
            end
        endcase
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
