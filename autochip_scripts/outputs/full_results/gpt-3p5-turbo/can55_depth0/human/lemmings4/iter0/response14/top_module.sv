module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    reg [4:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00001;  // Initial state, walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case (state)
                5'b00001:  // Walking left
                    if (bump_right) begin
                        state <= 5'b00010;  // Switching directions
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                    end else if (!ground) begin
                        state <= 5'b00011;  // Falling
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                        digging <= 1'b0;
                    end else if (dig) begin
                        state <= 5'b00100;  // Digging
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b1;
                    end
                5'b00010:  // Switching directions
                    if (!bump_right) begin
                        if (!ground) begin
                            state <= 5'b00011;  // Falling
                            walk_left <= 1'b0;
                            walk_right <= 1'b0;
                            aaah <= 1'b1;
                            digging <= 1'b0;
                        end else begin
                            state <= 5'b00001;  // Walking left
                            walk_left <= 1'b1;
                            walk_right <= 1'b0;
                            aaah <= 1'b0;
                            digging <= 1'b0;
                        end
                    end
                5'b00011:  // Falling
                    if (ground) begin
                        state <= 5'b00001;  // Walking left
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                    end
                5'b00100:  // Digging
                    if (!ground) begin
                        state <= 5'b00011;  // Falling
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                        digging <= 1'b0;
                    end
                    if (ground && !dig) begin
                        state <= 5'b00001;  // Walking left
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                    end
            endcase
        end
    end

endmodule
