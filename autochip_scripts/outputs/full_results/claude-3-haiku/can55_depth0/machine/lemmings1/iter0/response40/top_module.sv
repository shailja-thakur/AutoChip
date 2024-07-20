module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter WL = 1'b0; // Walking Left state
parameter WR = 1'b1; // Walking Right state

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WL; // Reset to initial state
    end
    else begin
        case (state)
            WL: begin
                if (bump_left) begin
                    state <= WR; // Transition to Walking Right state
                end
                else begin
                    state <= WL; // Stay in Walking Left state
                end
            end
            WR: begin
                if (bump_right) begin
                    state <= WL; // Transition to Walking Left state
                end
                else begin
                    state <= WR; // Stay in Walking Right state
                end
            end
            default: begin
                state <= WL; // Default to Walking Left state
            end
        endcase
    end
end

always @(*) begin
    if (state == WL) begin
        walk_left = 1'b1;
        walk_right = 1'b0;
    end
    else if (state == WR) begin
        walk_left = 1'b0;
        walk_right = 1'b1;
    end
    else begin
        walk_left = 1'b0;
        walk_right = 1'b0;
    end
end

endmodule
