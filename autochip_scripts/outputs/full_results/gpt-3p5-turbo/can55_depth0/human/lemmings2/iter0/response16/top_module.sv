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

    // Define states
    parameter IDLE = 0;
    parameter WALK_LEFT = 1;
    parameter WALK_RIGHT = 2;
    parameter FALL = 3;

    // Define outputs
    reg walk_left;
    reg walk_right;
    reg aaah;

    // Define current state
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to initial state
            state <= IDLE;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (ground == 0) begin
                        state <= FALL;
                        aaah <= 1;
                    end else if (bump_left == 1) begin
                        state <= WALK_RIGHT;
                        walk_left <= 0;
                        walk_right <= 1;
                    end else if (bump_right == 1) begin
                        state <= WALK_LEFT;
                        walk_left <= 1;
                        walk_right <= 0;
                    end
                end
                WALK_LEFT: begin
                    if (ground == 0) begin
                        state <= FALL;
                        aaah <= 1;
                    end else if (bump_right == 1) begin
                        state <= WALK_RIGHT;
                        walk_left <= 0;
                        walk_right <= 1;
                    end
                end
                WALK_RIGHT: begin
                    if (ground == 0) begin
                        state <= FALL;
                        aaah <= 1;
                    end else if (bump_left == 1) begin
                        state <= WALK_LEFT;
                        walk_left <= 1;
                        walk_right <= 0;
                    end
                end
                FALL: begin
                    if (ground == 1) begin
                        state <= state;
                        aaah <= 0;
                    end
                end
            endcase
        end
    end
endmodule
