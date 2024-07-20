module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the two states
parameter STATE_WALK_LEFT = 1'b0;
parameter STATE_WALK_RIGHT = 1'b1;

// Current state register
reg state;

// Next state logic
always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                state = STATE_WALK_RIGHT;
            end else begin
                state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                state = STATE_WALK_LEFT;
            end else begin
                state = STATE_WALK_RIGHT;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
        end
    endcase
end

// Sequential logic (state register)
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end else begin
        state <= state;
    end
end

endmodule
