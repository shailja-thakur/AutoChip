module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    reg [1:0] state;
    reg walk_left;
    reg walk_right;
    reg aaah;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
            walk_left <= 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
        end else begin
            case(state)
                2'b00:
                    if (bump_left && !bump_right) begin
                        state <= 2'b01;
                        walk_left <= 1'b0;
                        walk_right = 1'b1;
                        aaah = 1'b0;
                    end
                    if (!bump_left && bump_right) begin
                        state <= 2'b10;
                        walk_left <= 1'b1;
                        walk_right = 1'b0;
                        aaah = 1'b0;
                    end
                    if (bump_left && bump_right) begin
                        state <= 2'b01;
                        walk_left <= 1'b0;
                        walk_right = 1'b1;
                        aaah = 1'b0;
                    end
                    if (!bump_left && !bump_right) begin
                        state <= 2'b00;
                        walk_left <= 1'b1;
                        walk_right = 1'b0;
                        aaah = 1'b0;
                    end
                2'b01:
                    if (bump_left && !bump_right) begin
                        state <= 2'b01;
                        walk_left <= 1'b0;
                        walk_right = 1'b1;
                        aaah = 1'b0;
                    end
                    if (!bump_left && bump_right) begin
                        state <= 2'b10;
                        walk_left <= 1'b1;
                        walk_right = 1'b0;
                        aaah = 1'b0;
                    end
                    if (bump_left && bump_right) begin
                        state <= 2'b10;
                        walk_left <= 1'b1;
                        walk_right = 1'b0;
                        aaah = 1'b0;
                    end
                    if (!bump_left && !bump_right) begin
                        state <= 2'b00;
                        walk_left <= 1'b1;
                        walk_right = 1'b0;
                        aaah = 1'b0;
                    end
                2'b10:
                    if (bump_left && !bump_right) begin
                        state <= 2'b01;
                        walk_left <= 1'b0;
                        walk_right = 1'b1;
                        aaah = 1'b0;
                    end
                    if (!bump_left && bump_right) begin
                        state <= 2'b10;
                        walk_left <= 1'b1;
                        walk_right = 1'b0;
                        aaah = 1'b0;
                    end
                    if (bump_left && bump_right) begin
                        state <= 2'b01;
                        walk_left <= 1'b0;
                        walk_right = 1'b1;
                        aaah = 1'b0;
                    end
                    if (!bump_left && !bump_right) begin
                        state <= 2'b00;
                        walk_left <= 1'b1;
                        walk_right = 1'b0;
                        aaah = 1'b0;
                    end
            endcase
        end
    end

    always @(state) begin
        case(state)
            2'b00:
                aaah = 1'b1;
            default:
                aaah = 1'b0;
        endcase
    end

endmodule
