module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

reg [1:0] state; // Current state of the FSM

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset state and outputs
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (ground == 1'b0) begin
                    state <= FALL; // Fall state
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1; // Start falling and say "aaah!"
                end else if (bump_right == 1'b1) begin
                    state <= WALK_RIGHT; // Switch to walking right state
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                end else if (dig == 1'b1) begin
                    state <= DIG; // Dig state
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1; // Start digging
                end
            end
            WALK_RIGHT: begin
                if (ground == 1'b0) begin
                    state <= FALL; // Fall state
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1; // Start falling and say "aaah!"
                end else if (bump_left == 1'b1) begin
                    state <= WALK_LEFT; // Switch to walking left state
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                end else if (dig == 1'b1) begin
                    state <= DIG; // Dig state
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1; // Start digging
                end
            end
            FALL: begin
                if (ground == 1'b1) begin
                    state <= state; // Stay in falling state until ground reappears
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 1'b0; // Stop falling, don't change walking direction
                end
            end
            DIG: begin
                if (ground == 1'b0) begin
                    state <= state; // Stay in digging state until ground disappears
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= aaah;
                end else if (ground == 1'b1) begin
                    state <= WALK_LEFT; // Fall state after digging, walking left again
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= aaah;
                    digging <= 1'b0; // Stop digging
                end
            end
        endcase
    end
end

endmodule
