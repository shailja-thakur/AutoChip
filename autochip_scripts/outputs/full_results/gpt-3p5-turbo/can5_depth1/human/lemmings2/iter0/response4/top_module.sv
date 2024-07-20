module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // Initialize the state to walk left
        end else begin
            case (state)
                2'b00: // Fall state
                    if (ground) begin
                        if (bump_left && bump_right) begin
                            state <= 2'b01; // Switch directions if bumped on both sides
                        end else if (bump_left) begin
                            state <= 2'b01; // Switch directions if bumped on left side
                        end else if (bump_right) begin
                            state <= 2'b00; // Stay in the same state if bumped on right side
                        end
                    end
                2'b01: // Walk right state
                    if (ground) begin
                        if (bump_right) begin
                            state <= 2'b10; // Switch to walk left if bumped on right side
                        end else if (bump_left) begin
                            state <= 2'b01; // Stay in the same state if bumped on left side
                        end
                    end else begin
                        state <= 2'b00; // Go to fall state if ground disappears
                    end
                2'b10: // Walk left state
                    if (ground) begin
                        if (bump_left) begin
                            state <= 2'b01; // Switch to walk right if bumped on left side
                        end else if (bump_right) begin
                            state <= 2'b10; // Stay in the same state if bumped on right side
                        end
                    end else begin
                        state <= 2'b00; // Go to fall state if ground disappears
                    end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: // Fall state
                begin
                    walk_left = 1'b0;
                    walk_right = 1'b0;
                    aaah = 1'b1; // Output "aaah!" in the fall state
                end
            2'b01: // Walk right state
                begin
                    walk_left = 1'b0;
                    walk_right = 1'b1;
                    aaah = 1'b0;
                end
            2'b10: // Walk left state
                begin
                    walk_left = 1'b1;
                    walk_right = 1'b0;
                    aaah = 1'b0;
                end
        endcase
    end

endmodule
