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

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALLING: begin
            walk_left = state == WALK_LEFT;
            walk_right = state == WALK_RIGHT;
            aaah = 1'b1;
            if (ground) begin
                next_state = state;
            end
            else begin
                next_state = FALLING;
            end
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b0;
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
