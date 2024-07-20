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

parameter WALK_LEFT = 1'b1, WALK_RIGHT = 1'b0;

reg current_state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = WALK_LEFT;
                aaah = 1'b1;
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
                next_state = WALK_RIGHT;
                aaah = 1'b1;
            end
            else begin
                next_state = WALK_RIGHT;
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
