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
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        else begin
            case (state)

                // Walk left state
                5'b00001: begin
                    if (bump_right || (bump_left && !bump_right)) begin
                        state <= 5'b00010; // Walk right
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else if (!ground) begin
                        state <= 5'b00011; // Falling
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                    else if (dig) begin
                        state <= 5'b00100; // Digging
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end
                end

                // Walk right state
                5'b00010: begin
                    if (bump_left || (bump_left && !bump_right)) begin
                        state <= 5'b00001; // Walk left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else if (!ground) begin
                        state <= 5'b00011; // Falling
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                    else if (dig) begin
                        state <= 5'b00100; // Digging
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end
                end

                // Falling state
                5'b00011: begin
                    if (ground) begin
                        state <= 5'b00001; // Walk left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else if (state == 5'b10000 && !ground) begin
                        state <= 5'b10000; // Splatter
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else begin
                        state <= state + 1;
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end

                // Digging state
                5'b00100: begin
                    if (ground) begin
                        state <= 5'b00001; // Walk left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else if (state == 5'b10000 && !ground) begin
                        state <= 5'b10000; // Splatter
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else begin
                        state <= state + 1;
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 1;
                    end
                end

                // Splatter state
                5'b10000: begin
                    state <= 5'b10000; // Stay in splatter state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end

            endcase
        end
    end

endmodule
