module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define state enumeration
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT
    } state_type;

    // Define state register and next state logic
    state_type state, next_state;

    // Output logic
    assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
    assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;

    // Sequential logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic
    always @* begin
        case (state)
            WALK_LEFT:
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            WALK_RIGHT:
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
        endcase
    end

endmodule
