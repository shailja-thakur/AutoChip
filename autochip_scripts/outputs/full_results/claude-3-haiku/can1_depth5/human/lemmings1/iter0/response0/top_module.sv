module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the states
typedef enum {WALK_LEFT, WALK_RIGHT} state_t;
state_t state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default outputs
    walk_left = 1'b0;
    walk_right = 1'b0;

    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1'b1;
            if (bump_left) begin
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
