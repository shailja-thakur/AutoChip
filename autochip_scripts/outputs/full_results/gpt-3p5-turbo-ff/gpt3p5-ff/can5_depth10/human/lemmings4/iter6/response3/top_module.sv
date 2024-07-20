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
    reg [4:0] fall_count;
    reg [4:0] dig_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00001; // Walk left
            fall_count <= 5'b00000;
            dig_count <= 5'b00000;
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
                    if (fall_count >= 5'b10100 && !ground) begin
                        state <= 5'b10000; // Splatter
                    end
                    else if (ground) begin
                        state <= 5'b00001; // Walk left
                    end
                    else begin
                        state <= state + 1;
                    end
                end

                // Digging state
                5'b00100: begin
                    if (dig_count >= 5'b10100 && !ground) begin
                        state <= 5'b10000; // Splatter
                    end
                    else if (ground) begin
                        state <= 5'b00001; // Walk left
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
    always @(state) begin
        case (state)
            5'b00001: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
            5'b00010: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0;
            end
            5'b00011: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
            5'b00100: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1;
            end
            5'b10000: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0;
            end
        endcase
    end

endmodule
