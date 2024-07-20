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
    reg [4:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00001; // Walk left
        end
        else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;

        case (state)

            // Walk left state
            5'b00001: begin
                if (bump_right || (bump_left && !bump_right)) begin
                    next_state = 5'b00010; // Walk right
                end
                else if (!ground) begin
                    next_state = 5'b00011; // Falling
                end
                else if (dig) begin
                    next_state = 5'b00100; // Digging
                end
            end

            // Walk right state
            5'b00010: begin
                if (bump_left || (bump_left && !bump_right)) begin
                    next_state = 5'b00001; // Walk left
                end
                else if (!ground) begin
                    next_state = 5'b00011; // Falling
                end
                else if (dig) begin
                    next_state = 5'b00100; // Digging
                end
            end

            // Falling state
            5'b00011: begin
                if (ground) begin
                    next_state = 5'b00001; // Walk left
                end
                else if (state == 5'b10000 && !ground) begin
                    next_state = 5'b10000; // Splatter
                end
                else begin
                    next_state = state + 1;
                end
            end

            // Digging state
            5'b00100: begin
                if (ground) begin
                    next_state = 5'b00001; // Walk left
                end
                else if (state == 5'b10000 && !ground) begin
                    next_state = 5'b10000; // Splatter
                end
                else begin
                    next_state = state + 1;
                end
            end

            // Splatter state
            5'b10000: begin
                next_state = 5'b10000; // Stay in splatter state
            end

        endcase
    end

    // Generate output signals based on the current state
    always @* begin
        walk_left = (state == 5'b00001);
        walk_right = (state == 5'b00010);
        aaah = (state == 5'b00011 || state == 5'b10000);
        digging = (state == 5'b00100);
    end

endmodule
