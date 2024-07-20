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

// Define the states
parameter WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;
reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default values
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    
    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            if (ground == 1'b0) begin
                next_state = state;
                aaah = 1'b1;
            end
            else if (bump_right == 1'b1) begin
                next_state = WALK_RIGHT;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1'b1;
            if (ground == 1'b0) begin
                next_state = state;
                aaah = 1'b1;
            end
            else if (bump_left == 1'b1) begin
                next_state = WALK_LEFT;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
