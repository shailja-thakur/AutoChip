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

localparam [1:0] LEFT = 2'b00, RIGHT = 2'b01, FALL = 2'b10;
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            if (bump_right) begin
                next_state = RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
        end
        RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
            if (bump_left) begin
                next_state = LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
        end
        FALL: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b1;
            if (ground) begin
                if (state == LEFT) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = RIGHT;
                end
            end
        end
    endcase
end

endmodule
