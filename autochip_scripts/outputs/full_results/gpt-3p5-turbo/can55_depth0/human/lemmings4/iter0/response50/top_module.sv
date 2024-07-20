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
    reg walk_left_reg;
    reg walk_right_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 5'b00000;
            walk_left_reg <= 1'b1;
            walk_right_reg <= 1'b0;
        end else begin
            case (state)
                5'b00000: begin  // Walking left
                    if (bump_right && !bump_left) begin
                        state <= 5'b00001;
                        walk_left_reg <= 1'b0;
                        walk_right_reg <= 1'b1;
                    end else if (bump_right && bump_left) begin
                        state <= 5'b00001;
                        walk_left_reg <= 1'b0;
                        walk_right_reg <= 1'b1;
                    end else if (dig && ground) begin
                        state <= 5'b00010;
                        walk_left_reg <= 1'b1;
                        walk_right_reg <= 1'b0;
                    end else if (!ground) begin
                        state <= 5'b00011;
                        walk_left_reg <= 1'b0;
                        walk_right_reg <= 1'b0;
                    end
                end
                5'b00001: begin  // Walking right
                    if (bump_left && !bump_right) begin
                        state <= 5'b00000;
                        walk_left_reg <= 1'b1;
                        walk_right_reg <= 1'b0;
                    end else if (bump_left && bump_right) begin
                        state <= 5'b00000;
                        walk_left_reg <= 1'b1;
                        walk_right_reg <= 1'b0;
                    end else if (dig && ground) begin
                        state <= 5'b00010;
                        walk_left_reg <= 1'b1;
                        walk_right_reg <= 1'b0;
                    end else if (!ground) begin
                        state <= 5'b00011;
                        walk_left_reg <= 1'b0;
                        walk_right_reg <= 1'b0;
                    end
                end
                5'b00010: begin  // Digging
                    if (!ground) begin
                        state <= 5'b00011;
                        walk_left_reg <= 1'b0;
                        walk_right_reg <= 1'b0;
                    end
                end
                5'b00011: begin  // Falling
                    if (ground) begin
                        state <= 5'b00000;
                        walk_left_reg <= walk_left_reg;
                        walk_right_reg <= walk_right_reg;
                    end
                end
            endcase
        end
    end

    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            if (state == 5'b00011) begin
                aaah <= 1'b1;
                digging <= 1'b0;
            end else if (state == 5'b00010) begin
                aaah <= 1'b0;
                digging <= 1'b1;
            end else begin
                aaah <= 1'b0;
                digging <= 1'b0;
            end
        end
    end

endmodule
