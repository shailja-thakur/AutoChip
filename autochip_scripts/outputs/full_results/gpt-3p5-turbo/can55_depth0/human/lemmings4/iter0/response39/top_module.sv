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
            state <= 1;
        end else begin
            case(state)
                1: begin
                    if (bump_left) begin
                        state <= 3;
                    end else if (bump_right) begin
                        state <= 2;
                    end else if (ground) begin
                        state <= 4;
                    end else if (dig) begin
                        state <= 5;
                    end
                end
                2: begin
                    if (ground) begin
                        state <= 4;
                    end else begin
                        state <= 6;
                    end
                end
                3: begin
                    if (ground) begin
                        state <= 4;
                    end else begin
                        state <= 7;
                    end
                end
                4: begin
                    if (fall_count >= 20) begin
                        state <= 0;
                    end else if (bump_left) begin
                        state <= 3;
                    end else if (bump_right) begin
                        state <= 2;
                    end else if (!ground) begin
                        state <= 8;
                    end
                end
                5: begin
                    if (!ground || !walking_on_ground) begin
                        state <= 1;
                    end else if (!dig) begin
                        state <= 9;
                    end
                end
                6: begin
                    if (bump_left) begin
                        state <= 3;
                    end else if (!dig) begin
                        state <= 9;
                    end
                end
                7: begin
                    if (bump_right) begin
                        state <= 2;
                    end else if (!dig) begin
                        state <= 9;
                    end
                end
                8: begin
                    if (!ground) begin
                        state <= 8;
                    end else begin
                        state <= 4;
                    end
                end
                9: begin
                    if (!dig) begin
                        state <= 1;
                    end else if (ground) begin
                        state <= 4;
                    end
                end
            endcase
        end
    end

    assign walk_left = (state == 1 || state == 3);
    assign walk_right = (state == 2);
    assign aaah = (state == 4 || state == 6 || state == 7 || state == 8);
    assign digging = (state == 5 || state == 9);

endmodule
