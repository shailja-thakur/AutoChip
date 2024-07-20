module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;
reg state, next_state;

// State register
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else
                next_state = WALK_RIGHT;
        end
        default: next_state = WALK_LEFT;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
        end
    endcase
end

endmodule
