module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter WL = 0;
parameter WR = 1;

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WL;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end else begin
        state <= next_state;
        if (state == WL) begin
            if (bump_left)
                next_state <= WR;
            else
                next_state <= WL;
        end else begin // state == WR
            if (bump_right)
                next_state <= WL;
            else
                next_state <= WR;
        end
    end
end

always @(state) begin
    case (state)
        WL: begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end
        WR: begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
        end
        default: begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
        end
    endcase
end

endmodule
