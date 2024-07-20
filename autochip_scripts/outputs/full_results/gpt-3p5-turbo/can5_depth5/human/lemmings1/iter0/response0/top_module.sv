module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] state;

    // State definitions
    parameter LEFT = 2'b01;
    parameter RIGHT = 2'b10;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to initial state (walk_left)
            walk_left <= 1;
            walk_right <= 0;
            state <= LEFT;
        end
        else begin
            case (state)
                LEFT: begin
                    if (bump_right) begin
                        // Switch to RIGHT state if bumped on the right
                        walk_left <= 0;
                        walk_right <= 1;
                        state <= RIGHT;
                    end
                    else begin
                        // Continue walking left if no bump
                        walk_left <= 1;
                        walk_right <= 0;
                        state <= LEFT;
                    end
                end

                RIGHT: begin
                    if (bump_left) begin
                        // Switch to LEFT state if bumped on the left
                        walk_left <= 1;
                        walk_right <= 0;
                        state <= LEFT;
                    end
                    else begin
                        // Continue walking right if no bump
                        walk_left <= 0;
                        walk_right <= 1;
                        state <= RIGHT;
                    end
                end
            endcase
        end
    end
endmodule
