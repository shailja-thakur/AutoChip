module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    parameter WL = 1'b0;
    parameter WR = 1'b1;

    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
        end
        else begin
            case (state)
                WL:
                    if (bump_left) begin
                        state <= WR;
                    end
                    else begin
                        state <= WL;
                    end
                WR:
                    if (bump_right) begin
                        state <= WL;
                    end
                    else begin
                        state <= WR;
                    end
            endcase
        end
    end

    always @(*) begin
        if (state == WL) begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        else begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
    end

endmodule
