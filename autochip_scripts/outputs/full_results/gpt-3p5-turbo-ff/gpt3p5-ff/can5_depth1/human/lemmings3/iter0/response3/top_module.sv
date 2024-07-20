module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // Initial state: walk left
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
            aaah <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // Falling state
                    if (ground) begin
                        state <= 2'b01; // Transition to walking state
                        // Resume walking in the same direction
                        if (walk_left)
                            walk_left <= 1'b1;
                        else if (walk_right)
                            walk_right <= 1'b1;
                        else
                            walk_left <= 1'b0; // Default to walking left
                        aaah <= 1'b0;
                    end
                end
                2'b01: begin // Walking state
                    if (dig) begin
                        if (ground) begin
                            state <= 2'b10; // Transition to digging state
                            digging <= 1'b1;
                            walk_left <= 1'b0;
                            walk_right <= 1'b0;
                            aaah <= 1'b0;
                        end
                    end else begin
                        if (bump_left && !bump_right) begin
                            state <= 2'b11; // Transition to walking right state
                            walk_left <= 1'b0;
                            walk_right <= 1'b1;
                            aaah <= 1'b0;
                        end else if (!bump_left && bump_right) begin
                            state <= 2'b10; // Transition to walking left state
                            walk_left <= 1'b1;
                            walk_right <= 1'b0;
                            aaah <= 1'b0;
                        end else if (bump_left && bump_right) begin
                            state <= 2'b11; // Transition to walking right state
                            walk_left <= 1'b0;
                            walk_right <= 1'b1;
                            aaah <= 1'b0;
                        end
                    end
                end
                2'b10: begin // Walking left state
                    if (dig) begin
                        if (ground) begin
                            state <= 2'b10; // Remain in digging state
                        end else begin
                            state <= 2'b00; // Transition to falling state
                            digging <= 1'b0;
                            walk_left <= 1'b0;
                            walk_right <= 1'b0;
                            aaah <= 1'b1;
                            // Resume walking in the same direction after falling
                            if (walk_left)
                                walk_left <= 1'b1;
                            else if (walk_right)
                                walk_right <= 1'b1;
                            else
                                walk_left <= 1'b0; // Default to walking left
                        end
                    end else begin
                        if (bump_left && !bump_right) begin
                            state <= 2'b11; // Transition to walking right state
                            walk_left <= 1'b0;
                            walk_right <= 1'b1;
                            aaah <= 1'b0;
                        end else if (!bump_left && bump_right) begin
                            state <= 2'b10; // Remain in walking left state
                        end else if (bump_left && bump_right) begin
                            state <= 2'b11; // Transition to walking right state
                            walk_left <= 1'b0;
                            walk_right <= 1'b1;
                            aaah <= 1'b0;
                        end
                    end
                end
                2'b11: begin // Walking right state
                    if (dig) begin
                        if (ground) begin
                            state <= 2'b10; // Remain in digging state
                        end else begin
                            state <= 2'b00; // Transition to falling state
                            digging <= 1'b0;
                            walk_left <= 1'b0;
                            walk_right <= 1'b0;
                            aaah <= 1'b1;
                            // Resume walking in the same direction after falling
                            if (walk_left)
                                walk_left <= 1'b1;
                            else if (walk_right)
                                walk_right <= 1'b1;
                            else
                                walk_left <= 1'b0; // Default to walking left
                        end
                    end else begin
                        if (bump_left && !bump_right) begin
                            state <= 2'b10; // Transition to walking left state
                            walk_left <= 1'b1;
                            walk_right <= 1'b0;
                            aaah <= 1'b0;
                        end else if (!bump_left && bump_right) begin
                            state <= 2'b11; // Remain in walking right state
                        end else if (bump_left && bump_right) begin
                            state <= 2'b10; // Transition to walking left state
                            walk_left <= 1'b1;
                            walk_right <= 1'b0;
                            aaah <= 1'b0;
                        end
                    end
                end
            endcase
        end
    end

endmodule
