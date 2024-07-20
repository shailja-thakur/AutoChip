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
        LEFT  = 2'b01,
        RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // Sequential logic: state transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT; // On reset, the Lemming walks left
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic: next state logic
    always_comb begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT; // Switch to walking right on left bump
                end else begin
                    next_state = LEFT; // Continue walking left
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT; // Switch to walking left on right bump
                end else begin
                    next_state = RIGHT; // Continue walking right
                end
            end
            default: begin
                next_state = LEFT; // Default state
            end
        endcase
    end

    // Output logic: Moore machine output is based on current state
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
