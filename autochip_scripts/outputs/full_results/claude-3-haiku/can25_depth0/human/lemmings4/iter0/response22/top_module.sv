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

localparam [2:0] STATE_WALKING_LEFT = 3'b000,
                 STATE_WALKING_RIGHT = 3'b001,
                 STATE_FALLING = 3'b010,
                 STATE_DIGGING = 3'b011,
                 STATE_SPLATTERED = 3'b100;

reg [2:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALKING_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WALKING_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_counter <= 0;
            end
            STATE_WALKING_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                fall_counter <= 0;
            end
            STATE_FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                fall_counter <= fall_counter + 1;
            end
            STATE_DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                fall_counter <= 0;
            end
            STATE_SPLATTERED: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_counter <= 0;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_WALKING_LEFT: begin
            if (ground == 0) begin
                next_state = STATE_FALLING;
            end
            else if (dig == 1) begin
                next_state = STATE_DIGGING;
            end
            else if (bump_right == 1) begin
                next_state = STATE_WALKING_RIGHT;
            end
            else begin
                next_state = STATE_WALKING_LEFT;
            end
        end
        STATE_WALKING_RIGHT: begin
            if (ground == 0) begin
                next_state = STATE_FALLING;
            end
            else if (dig == 1) begin
                next_state = STATE_DIGGING;
            end
            else if (bump_left == 1) begin
                next_state = STATE_WALKING_LEFT;
            end
            else begin
                next_state = STATE_WALKING_RIGHT;
            end
        end
        STATE_FALLING: begin
            if (ground == 1) begin
                if (fall_counter >= 20) begin
                    next_state = STATE_SPLATTERED;
                end
                else begin
                    if (walk_left == 1) begin
                        next_state = STATE_WALKING_LEFT;
                    end
                    else begin
                        next_state = STATE_WALKING_RIGHT;
                    end
                end
            end
            else begin
                next_state = STATE_FALLING;
            end
        end
        STATE_DIGGING: begin
            if (ground == 0) begin
                next_state = STATE_FALLING;
            end
            else begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_SPLATTERED: begin
            next_state = STATE_SPLATTERED;
        end
    endcase
end

endmodule
