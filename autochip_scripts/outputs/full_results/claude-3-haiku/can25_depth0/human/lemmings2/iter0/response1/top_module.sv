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
parameter WALK_LEFT = 0, WALK_RIGHT = 1;

// Register to store the current state
reg [0:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                if (ground == 0) begin
                    state <= WALK_LEFT;
                    aaah <= 1;
                end
                else if (bump_right == 1) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                if (ground == 0) begin
                    state <= WALK_RIGHT;
                    aaah <= 1;
                end
                else if (bump_left == 1) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
            end
        endcase
    end
end

endmodule
