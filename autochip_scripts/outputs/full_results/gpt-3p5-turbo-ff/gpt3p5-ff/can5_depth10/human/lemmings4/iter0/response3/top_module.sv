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
            state <= 5'b00001; // Walk left
        end
        else begin
            case (state)

                // Walk left state
                5'b00001: begin
                    if (bump_right || (bump_left && !bump_right)) begin
                        state <= 5'b00010; // Walk right
                    end
                    else if (!ground) begin
                        state <= 5'b00011; // Falling
                    end
                    else if (dig) begin
                        state <= 5'b00100; // Digging
                    end
                end

                // Walk right state
                5'b00010: begin
                    if (bump_left || (bump_left && !bump_right)) begin
                        state <= 5'b00001; // Walk left
                    end
                    else if (!ground) begin
                        state <= 5'b00011; // Falling
                    end
                    else if (dig) begin
                        state <= 5'b00100; // Digging
                    end
                end

                // Falling state
                5'b00011: begin
                    if (ground) begin
                        state <= 5'b00001; // Walk left
                    end
                    else if (state == 5'b10000 && !ground) begin
                        state <= 5'b10000; // Splatter
                    end
                    else begin
                        state <= state + 1;
                    end
                end

                // Digging state
                5'b00100: begin
                    if (ground) begin
                        state <= 5'b00001; // Walk left
                    end
                    else if (state == 5'b10000 && !ground) begin
                        state <= 5'b10000; // Splatter
                    end
                    else begin
                        state <= state + 1;
                    end
                end

                // Splatter state
                5'b10000: begin
                    state <= 5'b10000; // Stay in splatter state
                end

            endcase
        end
    end

    // Generate output signals based on the current state
    assign walk_left = (state == 5'b00001);
    assign walk_right = (state == 5'b00010);
    assign aaah = (state == 5'b00011 || state == 5'b10000);
    assign digging = (state == 5'b00100);

endmodule
