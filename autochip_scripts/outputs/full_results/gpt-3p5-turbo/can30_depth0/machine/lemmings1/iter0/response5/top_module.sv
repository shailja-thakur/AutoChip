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
    if (areset)
        state <= WL;
    else
        state <= next_state;
end

always @(state or bump_left or bump_right) begin
    case (state)
        WL: begin
            if (bump_left)
                next_state = WR;
            else
                next_state = WL;
        end
        WR: begin
            if (bump_right)
                next_state = WL;
            else
                next_state = WR;
        end
    endcase
end

always @(state) begin
    if (state == WL) begin
        walk_left = 1;
        walk_right = 0;
    end else begin
        walk_left = 0;
        walk_right = 1;
    end
end

endmodule
