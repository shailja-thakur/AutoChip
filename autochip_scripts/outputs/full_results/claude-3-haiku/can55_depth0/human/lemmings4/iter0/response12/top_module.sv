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

parameter WALKING_LEFT = 2'b00;
parameter WALKING_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter DIGGING = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
        fall_count <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        fall_count <= (state == FALLING) ? fall_count + 1 : 0;
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
            walk_right = 1;
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
            aaah = 1;
            if (ground) begin
                if (fall_count > 20) begin
                    // Splatter
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end
                else begin
                    if (walk_left) begin
                        next_state = WALKING_LEFT;
                    end
                    else begin
                        next_state = WALKING_RIGHT;
                    end
                end
            end
        end
        DIGGING: begin
            digging = 1;
            if (!ground) begin
                next_state = FALLING;
            end
        end
    endcase
end

endmodule
