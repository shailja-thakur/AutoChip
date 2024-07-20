module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

localparam [1:0] LEFT = 2'b00, RIGHT = 2'b01;
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
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
    case (state)
        LEFT: begin
            if (bump_right) begin
                next_state = RIGHT;
            end
        end
        RIGHT: begin
            if (bump_left) begin
                next_state = LEFT;
            end
        end
    endcase
end

endmodule
