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

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // Initial state - walking left
        end else begin
            case (state)
                2'b00:  // Falling state
                    if (ground)
                        state <= bump_left || bump_right ? 2'b11 : 2'b01;
                2'b01:  // Walking left state
                    if (bump_left)
                        state <= 2'b10;  // Switch to walking right
                    else if (dig && ground)
                        state <= 2'b00;  // Start digging
                    else if (!ground)
                        state <= 2'b00;  // Start falling
                2'b10:  // Walking right state
                    if (bump_right)
                        state <= 2'b01;  // Switch to walking left
                    else if (dig && ground)
                        state <= 2'b00;  // Start digging
                    else if (!ground)
                        state <= 2'b00;  // Start falling
                2'b11:  // Splattered state
                    state <= 2'b11;
            endcase
        end
    end

    always @(state) begin
        walk_left = (state == 2'b01);
        walk_right = (state == 2'b10);
        aaah = (state == 2'b00 && ground);
        digging = (state == 2'b00 && !ground && dig);
    end

endmodule
