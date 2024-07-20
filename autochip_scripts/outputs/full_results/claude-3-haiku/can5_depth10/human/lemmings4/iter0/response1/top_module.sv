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

localparam [2:0] WALK_LEFT = 3'd0,
                 WALK_RIGHT = 3'd1,
                 FALLING = 3'd2,
                 DIGGING = 3'd3,
                 SPLATTERED = 3'd4;

reg [2:0] current_state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        fall_counter <= 0;
    end
    else begin
        current_state <= next_state;
        fall_counter <= (current_state == FALLING) ? fall_counter + 1 : 0;
    end
end

always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig && ground) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig && ground) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALLING: begin
            aaah = 1;
            if (fall_counter >= 20 && !ground) begin
                next_state = SPLATTERED;
            end
            else if (ground) begin
                if (walk_left) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
            else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            digging = 1;
            if (!ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = DIGGING;
            end
        end
        SPLATTERED: begin
            // Do nothing, stay in SPLATTERED state
            next_state = SPLATTERED;
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
