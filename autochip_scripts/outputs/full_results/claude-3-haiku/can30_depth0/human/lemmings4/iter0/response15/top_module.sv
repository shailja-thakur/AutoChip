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

localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALLING = 2;
localparam STATE_DIGGING = 3;
localparam STATE_SPLATTERED = 4;

reg [2:0] current_state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        fall_counter <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        current_state <= next_state;
        fall_counter <= (current_state == STATE_FALLING) ? fall_counter + 1 : 0;
    end
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = STATE_SPLATTERED;
                end
                else begin
                    if (walk_left) begin
                        next_state = STATE_WALK_LEFT;
                    end
                    else begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end
            end
        end
        STATE_DIGGING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
            if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (!dig) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
        STATE_SPLATTERED: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    endcase
end

endmodule
