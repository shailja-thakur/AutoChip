module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter WL = 1'b0; // Walking left state
parameter WR = 1'b1; // Walking right state

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WL; // Reset to initial state (walking left)
    end
    else begin
        case (state)
            WL: begin
                if (bump_left) begin
                    state <= WR; // Transition to walking right state
                end
                else begin
                    state <= WL; // Stay in walking left state
                end
            end
            WR: begin
                if (bump_right) begin
                    state <= WL; // Transition to walking left state
                end
                else begin
                    state <= WR; // Stay in walking right state
                end
            end
            default: begin
                state <= WL; // Default to walking left state
            end
        endcase
    end
end

always @* begin
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
