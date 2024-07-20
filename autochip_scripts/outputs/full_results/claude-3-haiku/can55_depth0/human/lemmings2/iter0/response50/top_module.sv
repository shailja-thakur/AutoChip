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

// Define the states of the Lemming's behavior
localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

reg current_state, next_state;

// Asynchronous reset
always @(posedge areset) begin
    current_state <= STATE_WALK_LEFT;
    walk_left <= 1'b1;
    walk_right <= 1'b0;
    aaah <= 1'b0;
end

// Sequential logic for state transitions
always @(posedge clk) begin
    current_state <= next_state;
end

// Combinational logic for next state and outputs
always @(*) begin
    next_state = current_state;
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;

    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            if (!ground) begin
                aaah = 1'b1;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            if (!ground) begin
                aaah = 1'b1;
            end
        end
    endcase

    // Handle ground changes
    if (!ground && (current_state == STATE_WALK_LEFT || current_state == STATE_WALK_RIGHT)) begin
        aaah = 1'b1;
    end
    if (ground && (current_state == STATE_WALK_LEFT || current_state == STATE_WALK_RIGHT)) begin
        aaah = 1'b0;
    end
end

endmodule
