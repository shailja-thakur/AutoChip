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
                 SPLATTER = 3'd4;

reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == FALLING) begin
            fall_count <= fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
    end
end

always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
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
            if (ground) begin
                if (fall_count >= 20) begin
                    next_state = SPLATTER;
                end
                else begin
                    if (walk_left) begin
                        next_state = WALK_LEFT;
                    end
                    else begin
                        next_state = WALK_RIGHT;
                    end
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
        SPLATTER: begin
            // Do nothing
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
