module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define states
    parameter WALK_LEFT = 1'b0;
    parameter WALK_RIGHT = 1'b1;
    
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1'b1; // Always start walking left on reset
            walk_right <= 1'b0; // Make sure walk_right is initially off
        end else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                    end
                end
                WALK_RIGHT: begin
                    if (bump_left) begin
                        state <= WALK_LEFT;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
