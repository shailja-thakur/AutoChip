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

reg cur_state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        cur_state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end
    else begin
        cur_state <= next_state;
        walk_left <= (cur_state == LEFT) ? 1 : 0;
        walk_right <= (cur_state == RIGHT) ? 1 : 0;
    end
end

always @(*) begin
    aaah = 0;
    case (cur_state)
        LEFT: begin
            if (ground == 0) begin
                next_state = LEFT;
                aaah = 1;
            end
            else if (bump_right == 1) begin
                next_state = RIGHT;
            end
            else begin
                next_state = LEFT;
            end
        end
        RIGHT: begin
            if (ground == 0) begin
                next_state = RIGHT;
                aaah = 1;
            end
            else if (bump_left == 1) begin
                next_state = LEFT;
            end
            else begin
                next_state = RIGHT;
            end
        end
    endcase
end

endmodule
