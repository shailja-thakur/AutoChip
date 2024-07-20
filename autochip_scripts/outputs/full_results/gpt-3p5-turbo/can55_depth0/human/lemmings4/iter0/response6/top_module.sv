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
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 5'b00000;  // Initial state, walking left
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case (state)
            5'b00000: begin  // Walking left
                if (bump_right && !bump_left) begin
                    state <= 5'b00001;  // Walking right
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end else if ((!bump_right && bump_left) || (bump_right && bump_left)) begin
                    state <= 5'b00001;  // Walking right
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end else if (!ground) begin
                    state <= 5'b00010;  // Falling
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (dig) begin
                    state <= 5'b00011;  // Digging
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
            end
            5'b00001: begin  // Walking right
                if (bump_left && !bump_right) begin
                    state <= 5'b00000;  // Walking left
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end else if ((!bump_left && bump_right) || (bump_right && bump_left)) begin
                    state <= 5'b00000;  // Walking left
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end else if (!ground) begin
                    state <= 5'b00010;  // Falling
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (dig) begin
                    state <= 5'b00011;  // Digging
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
            end
            5'b00010: begin  // Falling
                if (ground) begin
                    if (state[4:0] >= 5) begin
                        state <= 5'b00000;  // Walking left
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end else begin
                        state <= state + 1;  // Continue falling
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 1;
                        digging <= 0;
                    end
                end else begin
                    state <= state;  // Continue falling
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
            end
            5'b00011: begin  // Digging
                if (!ground) begin
                    state <= 5'b00010;  // Falling
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else begin
                    state <= 5'b00000;  // Walking left
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            end
        endcase
    end
end

endmodule
