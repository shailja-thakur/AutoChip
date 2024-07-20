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

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Initial state: walking left
        end else begin
            state <= next_state; // Update state
        end
    end

    always @(state or bump_left or bump_right or ground or dig) begin
        next_state = state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            2'b00: begin // Walking left
                if (bump_right == 1) begin
                    next_state = 2'b01; // Switch to walking right
                end else if (ground == 0) begin
                    next_state = 2'b10; // Fall state
                    aaah = 1; // Emit "aaah!"
                end else if (dig == 1 && ground == 1) begin
                    next_state = 2'b11; // Digging state
                    digging = 1; // Start digging
                end else begin
                    walk_left = 1; // Continue walking left
                end
            end
            2'b01: begin // Walking right
                if (bump_left == 1) begin
                    next_state = 2'b00; // Switch to walking left
                end else if (ground == 0) begin
                    next_state = 2'b10; // Fall state
                    aaah = 1; // Emit "aaah!"
                end else if (dig == 1 && ground == 1) begin
                    next_state = 2'b11; // Digging state
                    digging = 1; // Start digging
                end else begin
                    walk_right = 1; // Continue walking right
                end
            end
            2'b10: begin // Falling state
                if (ground == 1) begin
                    if (state == 2'b00) begin
                        next_state = 2'b00; // Continue walking left after fall
                        walk_left = 1;
                    end else begin
                        next_state = 2'b01; // Continue walking right after fall
                        walk_right = 1;
                    end
                end
            end
            2'b11: begin // Digging state
                if (ground == 0) begin
                    next_state = 2'b10; // Fall state after digging
                    aaah = 1; // Emit "aaah!"
                end else begin
                    digging = 1; // Continue digging
                end
            end
        endcase
    end

endmodule
