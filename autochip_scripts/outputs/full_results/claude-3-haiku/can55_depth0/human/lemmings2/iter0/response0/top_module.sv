module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

localparam LEFT = 1'b1;
localparam RIGHT = 1'b0;

reg state;
reg next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == LEFT);
        walk_right <= (state == RIGHT);
    end
end

always @(*) begin
    next_state = state;
    aaah = 0;

    case (state)
        LEFT: begin
            if (bump_right) begin
                next_state = RIGHT;
            end
            else if (!ground) begin
                next_state = state;
                aaah = 1;
            end
        end
        RIGHT: begin
            if (bump_left) begin
                next_state = LEFT;
            end
            else if (!ground) begin
                next_state = state;
                aaah = 1;
            end
        end
    endcase

    if (!ground) begin
        walk_left = state;
        walk_right = ~state;
    end
end

endmodule
