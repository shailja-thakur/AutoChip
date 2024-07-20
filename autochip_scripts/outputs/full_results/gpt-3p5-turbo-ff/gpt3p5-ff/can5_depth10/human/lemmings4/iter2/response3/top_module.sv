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

    reg [3:0] state;
    reg [4:0] fall_count;
    reg [4:0] dig_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 4'b0000; // Walk left
            fall_count <= 5'b00000;
            dig_count <= 5'b00000;
        end
        else begin
            case (state)

                // Walk left state
                4'b0000: begin
                    if (bump_right) begin
                        state <= 4'b0010; // Walk right
                    end
                    else if (bump_left) begin
                        state <= 4'b0001; // Walk left
                    end
                    else if (!ground) begin
                        state <= 4'b0100; // Falling
                    end
                    else if (dig) begin
                        state <= 4'b1000; // Digging
                    end
                end

                // Walk right state
                4'b0001: begin
                    if (bump_left) begin
                        state <= 4'b0001; // Walk left
                    end
                    else if (bump_right) begin
                        state <= 4'b0010; // Walk right
                    end
                    else if (!ground) begin
                        state <= 4'b0100; // Falling
                    end
                    else if (dig) begin
                        state <= 4'b1000; // Digging
                    end
                end

                // Falling state
                4'b0010: begin
                    if (ground) begin
                        state <= 4'b0000; // Walk left
                    end
                    else if (fall_count >= 5'b10100) begin
                        state <= 4'b0110; // Splatter
                    end
                    else begin
                        fall_count <= fall_count + 1;
                        state <= 4'b0010;
                    end
                end

                // Digging state
                4'b0100: begin
                    if (ground) begin
                        state <= 4'b0000; // Walk left
                    end
                    else if (dig_count >= 5'b10100) begin
                        state <= 4'b0110; // Splatter
                    end
                    else begin
                        dig_count <= dig_count + 1;
                        state <= 4'b0100;
                    end
                end

                // Splatter state
                4'b0110: begin
                    state <= 4'b0110; // Stay in splatter state
                end

            endcase
        end
    end

    // Generate output signals based on the current state
    always @(state) begin
        case (state)
            4'b0000: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
            4'b0001: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0;
            end
            4'b0010: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0;
            end
            4'b0100: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1;
            end
            4'b0110: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule
