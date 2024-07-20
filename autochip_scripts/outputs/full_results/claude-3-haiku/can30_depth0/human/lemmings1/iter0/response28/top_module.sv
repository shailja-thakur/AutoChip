module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Declare the states
localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

// Declare the current state register
reg current_state;

// Asynchronous reset
always @(posedge areset) begin
    current_state <= STATE_WALK_LEFT;
    walk_left <= 1'b1;
    walk_right <= 1'b0;
end

// State transition logic
always @(posedge clk) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                current_state <= STATE_WALK_RIGHT;
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end else begin
                current_state <= STATE_WALK_LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                current_state <= STATE_WALK_LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end else begin
                current_state <= STATE_WALK_RIGHT;
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end
        end
        default: begin
            current_state <= STATE_WALK_LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end
    endcase
end

endmodule
