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
            state <= 2'b00; // Walk left
            fall_count <= 5'b00000;
            dig_count <= 5'b00000;
        end
        else begin
            case (state)

                // Walk left state
                2'b00: begin
                    if (bump_right || (bump_left && !bump_right)) begin
                        state <= 2'b01; // Walk right
                    end
                    else if (!ground) begin
                        state <= 2'b10; // Falling
                    end
                    else if (dig && ground) begin
                        state <= 2'b11; // Digging
                    end
                end

                // Walk right state
                2'b01: begin
                    if (bump_left || (bump_left && !bump_right)) begin
                        state <= 2'b00; // Walk left
                    end
                    else if (!ground) begin
                        state <= 2'b10; // Falling
                    end
                    else if (dig && ground) begin
                        state <= 2'b11; // Digging
                    end
                end

                // Falling state
                2'b10: begin
                    if (ground) begin
                        state <= 2'b00; // Walk left
                    end
                    else if (fall_count >= 5'b10100 && !ground) begin
                        state <= 2'b10; // Splatter
                    end
                    else begin
                        fall_count <= fall_count + 1;
                    end
                end

                // Digging state
                2'b11: begin
                    if (ground) begin
                        state <= 2'b00; // Walk left
                    end
                    else if (dig_count >= 5'b10100 && ground) begin
                        state <= 2'b10; // Splatter
                    end
                    else begin
                        dig_count <= dig_count + 1;
                    end
                end

            endcase
        end
    end

    // Generate output signals based on the current state
    always @* begin
        walk_left = (state == 2'b00);
        walk_right = (state == 2'b01);
        aaah = (state == 2'b10 || state == 2'b11);
        digging = (state == 2'b11);
    end

endmodule
