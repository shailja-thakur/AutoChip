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
    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            case (state)
                2'b00: begin // Left
                    if (bump_right && !bump_left) begin
                        state <= 2'b01;
                    end else if (!bump_right && bump_left) begin
                        state <= 2'b00;
                    end else if (bump_right && bump_left) begin
                        state <= 2'b01;
                    end else begin
                        if (!ground) begin
                            state <= 2'b11;
                        end else begin
                            state <= 2'b00;
                        end
                    end
                end
                2'b01: begin // Right
                    if (bump_right && !bump_left) begin
                        state <= 2'b01;
                    end else if (!bump_right && bump_left) begin
                        state <= 2'b00;
                    end else if (bump_right && bump_left) begin
                        state <= 2'b00;
                    end else begin
                        if (!ground) begin
                            state <= 2'b11;
                        end else begin
                            state <= 2'b01;
                        end
                    end
                end
                2'b10: begin // Fall
                    if (!ground) begin
                        state <= 2'b10;
                    end else begin
                        if (walk_left) begin
                            state <= 2'b00;
                        end else begin
                            state <= 2'b01;
                        end
                    end
                end
                2'b11: begin // Dig
                    if (!ground) begin
                        state <= 2'b11;
                    end else begin
                        if (walk_left) begin
                            state <= 2'b00;
                        end else begin
                            state <= 2'b01;
                        end
                    end
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: begin // Left
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
            2'b01: begin // Right
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0;
            end
            2'b10: begin // Fall
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0;
            end
            2'b11: begin // Dig
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1;
            end
        endcase
    end

endmodule
