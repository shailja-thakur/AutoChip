module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

localparam [2:0] WALK_LEFT = 3'd0, WALK_RIGHT = 3'd1, FALLING = 3'd2, DIGGING = 3'd3, SPLATTER = 3'd4;
reg [2:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_counter <= 5'd0;
    end else begin
        state <= next_state;
        if (state == FALLING) begin
            fall_counter <= fall_counter + 1;
        end else begin
            fall_counter <= 5'd0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (~ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (~ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = SPLATTER;
                end else begin
                    if (bump_left) begin
                        next_state = WALK_RIGHT;
                    end else if (bump_right) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                    end
                end
            end
        end
        DIGGING: begin
            if (~ground) begin
                next_state = FALLING;
            end else if (~dig) begin
                next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
            end
        end
        SPLATTER: begin
            // Stay in SPLATTER state
        end
    endcase
end

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALLING);
assign digging = (state == DIGGING);

endmodule
