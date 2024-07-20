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

localparam [1:0] WALKING_LEFT = 2'd0, WALKING_RIGHT = 2'd1, FALLING = 2'd2, DIGGING = 2'd3;
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            WALKING_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            WALKING_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            FALLING: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
            end
            DIGGING: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        WALKING_LEFT: begin
            if (bump_right) begin
                next_state = WALKING_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALKING_LEFT;
            end
        end
        WALKING_RIGHT: begin
            if (bump_left) begin
                next_state = WALKING_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALKING_RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                next_state = (walk_left) ? WALKING_LEFT : WALKING_RIGHT;
            end
            else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = DIGGING;
            end
        end
    endcase
end

endmodule
