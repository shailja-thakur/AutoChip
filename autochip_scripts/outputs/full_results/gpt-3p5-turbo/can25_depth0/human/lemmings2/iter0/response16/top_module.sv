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
            state <= 2'b01; // Reset state to walk_left
        end else begin
            case (state)
                2'b00: begin // State walk_left
                    if (bump_right) begin
                        state <= 2'b10; // Switch to state walk_right
                    end else if (!ground) begin
                        state <= 2'b11; // Switch to state fall
                    end
                end
                2'b01: begin // State walk_right
                    if (bump_left) begin
                        state <= 2'b00; // Switch to state walk_left
                    end else if (!ground) begin
                        state <= 2'b11; // Switch to state fall
                    end
                end
                2'b10: begin // State fall
                    if (ground) begin
                        if (state == 2'b00) begin
                            state <= 2'b00; // Switch to state walk_left
                        end else if (state == 2'b01) begin
                            state <= 2'b01; // Switch to state walk_right
                        end
                    end
                end
                default: begin
                    state <= 2'b01; // Default to state walk_right
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00:
                begin   // State walk_left
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                end
            2'b01:
                begin   // State walk_right
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                end
            2'b10:
                begin   // State fall
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 1;
                end
            2'b11:
                begin   // State fall
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 1;
                end
        endcase
    end

endmodule
