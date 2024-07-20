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

localparam WALKING_LEFT = 2'd0;
localparam WALKING_RIGHT = 2'd1;
localparam FALLING = 2'd2;
localparam DIGGING = 2'd3;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALKING_LEFT: begin
            walk_left = 1;
            if (ground == 0) begin
                next_state = FALLING;
            end else if (bump_right == 1) begin
                next_state = WALKING_RIGHT;
            end else if (dig == 1) begin
                next_state = DIGGING;
            end
        end
        WALKING_RIGHT: begin
            walk_right = 1;
            if (ground == 0) begin
                next_state = FALLING;
            end else if (bump_left == 1) begin
                next_state = WALKING_LEFT;
            end else if (dig == 1) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            aaah = 1;
            if (ground == 1) begin
                if (walk_left) begin
                    next_state = WALKING_LEFT;
                end else begin
                    next_state = WALKING_RIGHT;
                end
            end
        end
        DIGGING: begin
            digging = 1;
            if (ground == 0) begin
                next_state = FALLING;
            end
        end
    endcase
end

endmodule
