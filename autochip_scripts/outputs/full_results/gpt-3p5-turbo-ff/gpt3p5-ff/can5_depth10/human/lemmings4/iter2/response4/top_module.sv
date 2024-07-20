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

    reg [2:0] state;
    reg [4:0] fall_count;
    reg [4:0] dig_count;
    reg [3:0] splatter_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 3'b000; // Walk left
            fall_count <= 5'b00000;
            dig_count <= 5'b00000;
            splatter_count <= 4'b0000;
        end
        else begin
            case (state)

                // Walk left state
                3'b000: begin
                    if (bump_right || (bump_left && !bump_right)) begin
                        state <= 3'b001; // Walk right
                    end
                    else if (!ground) begin
                        state <= 3'b100; // Falling
                    end
                    else if (dig) begin
                        state <= 3'b010; // Digging
                    end
                end

                // Walk right state
                3'b001: begin
                    if (bump_left || (bump_left && !bump_right)) begin
                        state <= 3'b000; // Walk left
                    end
                    else if (!ground) begin
                        state <= 3'b100; // Falling
                    end
                    else if (dig) begin
                        state <= 3'b010; // Digging
                    end
                end

                // Falling state
                3'b100: begin
                    if (ground) begin
                        state <= 3'b000; // Walk left
                    end
                    else if (fall_count >= 5'b10100 && !ground) begin
                        state <= 3'b101; // Splatter
                    end
                    else begin
                        fall_count <= fall_count + 1;
                        state <= 3'b100;
                    end
                end

                // Digging state
                3'b010: begin
                    if (ground) begin
                        state <= 3'b000; // Walk left
                    end
                    else if (dig_count >= 5'b10100 && !ground) begin
                        state <= 3'b101; // Splatter
                    end
                    else begin
                        dig_count <= dig_count + 1;
                        state <= 3'b010;
                    end
                end

                // Splatter state
                3'b101: begin
                    if (splatter_count >= 4'b1000) begin
                        state <= 3'b101; // Stay in splatter state
                    end
                    else begin
                        splatter_count <= splatter_count + 1;
                        state <= 3'b101;
                    end
                end

            endcase
        end
    end

    // Generate output signals based on the current state
    always @(state) begin
        case (state)
            3'b000: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
            3'b001: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0;
            end
            3'b100: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0;
            end
            3'b010: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1;
            end
            3'b101: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule
