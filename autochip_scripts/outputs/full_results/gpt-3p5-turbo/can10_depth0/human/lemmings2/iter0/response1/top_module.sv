module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

// Internal State Declaration
reg [1:0] state;

// State Definitions
parameter IDLE = 2'b00;
parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

// Output Assignments
assign aaah = (state == IDLE) ? 1'b1 : 1'b0;
assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;

// State Transition Logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;  // Reset to initial state
    end
    else begin
        case (state)
            IDLE: begin
                if (ground == 0) begin
                    state <= IDLE;  // Stay in the same state
                end
                else if (bump_left == 1) begin
                    state <= WALK_RIGHT;  // Transition to WALK_RIGHT state
                end
                else if (bump_right == 1) begin
                    state <= WALK_LEFT;  // Transition to WALK_LEFT state
                end
            end

            WALK_LEFT: begin
                if (ground == 0) begin
                    state <= IDLE;  // Transition to IDLE state
                end
                else if (bump_right == 1) begin
                    state <= WALK_LEFT;  // Stay in the same state
                end
                else begin
                    state <= WALK_LEFT;  // Stay in the same state
                end
            end

            WALK_RIGHT: begin
                if (ground == 0) begin
                    state <= IDLE;  // Transition to IDLE state
                end
                else if (bump_left == 1) begin
                    state <= WALK_RIGHT;  // Stay in the same state
                end
                else begin
                    state <= WALK_RIGHT;  // Stay in the same state
                end
            end
        endcase
    end
end

endmodule
