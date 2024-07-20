module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define the two states
    parameter STATE_WALK_LEFT = 2'b00;
    parameter STATE_WALK_RIGHT = 2'b01;

    reg [1:0] state;
    reg walk_left_reg;
    reg walk_right_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state machine to initial state
            state <= STATE_WALK_LEFT;
            walk_left_reg <= 0;
            walk_right_reg <= 0;
        end else begin
            // State transition logic
            case(state)
                STATE_WALK_LEFT: begin
                    if (bump_left) begin
                        state <= STATE_WALK_RIGHT;
                    end
                end
                STATE_WALK_RIGHT: begin
                    if (bump_right) begin
                        state <= STATE_WALK_LEFT;
                    end
                end
            endcase
        end
    end

    always @(state) begin
        // Output logic
        case(state)
            STATE_WALK_LEFT: begin
                walk_left_reg <= 1;
                walk_right_reg <= 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left_reg <= 0;
                walk_right_reg <= 1;
            end
        endcase
    end

    // Assign outputs
    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;

endmodule
