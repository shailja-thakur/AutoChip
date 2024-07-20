module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    
    parameter WL = 1'b0;  // state WL
    parameter WR = 1'b1;  // state WR

    reg state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end

    always @* begin
        if (state == WL) begin
            if (bump_left)
                next_state = WR;
            else
                next_state = WL;

            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        else if (state == WR) begin
            if (bump_right)
                next_state = WL;
            else
                next_state = WR;

            walk_left = 1'b0;
            walk_right = 1'b1;
        end
    end

endmodule
