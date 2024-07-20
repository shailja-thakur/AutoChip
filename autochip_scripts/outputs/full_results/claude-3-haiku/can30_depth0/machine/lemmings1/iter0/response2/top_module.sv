module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter WL = 1'b0, WR = 1'b1;
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WL;
    end
    else begin
        case (state)
            WL: begin
                if (bump_left)
                    state <= WR;
                else
                    state <= WL;
            end
            WR: begin
                if (bump_right)
                    state <= WL;
                else
                    state <= WR;
            end
            default: begin
                state <= WL;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        WL: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        WR: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
        end
    endcase
end

endmodule
