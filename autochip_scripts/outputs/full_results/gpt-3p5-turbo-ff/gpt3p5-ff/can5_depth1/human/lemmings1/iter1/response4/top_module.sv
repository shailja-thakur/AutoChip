module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define states
    parameter WALK_LEFT = 1'b0;
    parameter WALK_RIGHT = 1'b1;
    
    reg state;
    wire opposite_bump;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to walk left
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end
                end
                WALK_RIGHT: begin
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end
                end
            endcase
        end
    end
    
    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign opposite_bump = bump_left & bump_right;
    
    always @(posedge clk) begin
        if (opposite_bump) begin
            // Switch directions if bumped on both sides
            state <= ~state;
        end
    end

endmodule
