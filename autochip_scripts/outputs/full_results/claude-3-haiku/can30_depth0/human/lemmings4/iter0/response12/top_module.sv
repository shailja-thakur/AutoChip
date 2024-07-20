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

    // State variables
    reg [4:0] state;
    parameter [4:0] WALK_LEFT = 5'd0,
                    WALK_RIGHT = 5'd1,
                    FALLING = 5'd2,
                    DIGGING = 5'd3,
                    SPLATTER = 5'd4;

    // Fall counter
    reg [4:0] fall_count;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            fall_count <= 0;
        end
        else begin
            case (state)
                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                    if (bump_right)
                        state <= WALK_RIGHT;
                    else if (~ground)
                        state <= FALLING;
                    else if (dig & ground)
                        state <= DIGGING;
                end
                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                    if (bump_left)
                        state <= WALK_LEFT;
                    else if (~ground)
                        state <= FALLING;
                    else if (dig & ground)
                        state <= DIGGING;
                end
                FALLING: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall_count <= fall_count + 1;
                    if (ground)
                        state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                    else if (fall_count == 20)
                        state <= SPLATTER;
                end
                DIGGING: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall_count <= 0;
                    if (~ground)
                        state <= FALLING;
                    else if (~dig)
                        state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end
                SPLATTER: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
            endcase
        end
    end

endmodule
