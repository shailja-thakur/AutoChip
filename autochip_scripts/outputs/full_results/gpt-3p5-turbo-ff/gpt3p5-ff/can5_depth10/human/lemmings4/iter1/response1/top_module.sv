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

    reg [4:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00001; // Walk left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end
        else begin
            case (state)

                // Walk left state
                5'b00001: begin
                    if (bump_right || (bump_left && !bump_right)) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= 5'b00010; // Walk right
                    end
                    else if (!ground) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                        digging <= 1'b0;
                        state <= 5'b00011; // Falling
                    end
                    else if (dig) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b1;
                        state <= 5'b00100; // Digging
                    end
                end

                // Walk right state
                5'b00010: begin
                    if (bump_left || (bump_left && !bump_right)) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= 5'b00001; // Walk left
                    end
                    else if (!ground) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                        digging <= 1'b0;
                        state <= 5'b00011; // Falling
                    end
                    else if (dig) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b1;
                        state <= 5'b00100; // Digging
                    end
                end

                // Falling state
                5'b00011: begin
                    if (ground) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= 5'b00001; // Walk left
                    end
                    else if (state == 5'b10000 && !ground) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= 5'b10000; // Splatter
                    end
                    else begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= state + 1;
                    end
                end

                // Digging state
                5'b00100: begin
                    if (ground) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= 5'b00001; // Walk left
                    end
                    else if (state == 5'b10000 && !ground) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= 5'b10000; // Splatter
                    end
                    else begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                        state <= state + 1;
                    end
                end

                // Splatter state
                5'b10000: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    state <= 5'b10000; // Stay in splatter state
                end

            endcase
        end
    end

endmodule
