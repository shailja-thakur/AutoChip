module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define the two states
    parameter WALK_LEFT = 1'b0;
    parameter WALK_RIGHT = 1'b1;
    
    // Define the current state
    reg state;
    
    always @(posedge clk) begin
        if (areset) begin
            // Reset the state to walk left
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT:
                    begin
                        if (bump_right) begin
                            // If bumped on the right, switch to walk right
                            state <= WALK_RIGHT;
                        end else if (bump_left) begin
                            // If bumped on the left, remain in walk left
                            state <= WALK_LEFT;
                        end
                    end
                WALK_RIGHT:
                    begin
                        if (bump_left) begin
                            // If bumped on the left, switch to walk left
                            state <= WALK_LEFT;
                        end else if (bump_right) begin
                            // If bumped on the right, remain in walk right
                            state <= WALK_RIGHT;
                        end
                    end
            endcase
        end
    end

    always @(state) begin
        // Assign outputs based on the current state
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
    end

endmodule
