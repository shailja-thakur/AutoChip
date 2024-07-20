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

localparam [1:0] WALKING_LEFT = 2'b00, WALKING_RIGHT = 2'b01, FALLING = 2'b10, DIGGING = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALKING_LEFT);
        walk_right <= (state == WALKING_RIGHT);
        aaah <= (state == FALLING);
        digging <= (state == DIGGING);
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALKING_LEFT: begin
            if (bump_right) begin
                next_state = WALKING_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig && ground) begin
                next_state = DIGGING;
            end
        end
        WALKING_RIGHT: begin
            if (bump_left) begin
                next_state = WALKING_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig && ground) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            if (ground) begin
                if (walk_left) begin
                    next_state = WALKING_LEFT;
                end
                else begin
                    next_state = WALKING_RIGHT;
                end
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;
            end
            else if (!dig) begin
                if (walk_left) begin
                    next_state = WALKING_LEFT;
                end
                else begin
                    next_state = WALKING_RIGHT;
                end
            end
        end
    endcase
end

endmodule
