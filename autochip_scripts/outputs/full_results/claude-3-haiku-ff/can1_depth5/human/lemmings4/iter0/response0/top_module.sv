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

localparam [2:0] WALK_LEFT = 3'b000,
                 WALK_RIGHT = 3'b001,
                 FALL = 3'b010,
                 DIG = 3'b011,
                 SPLATTER = 3'b100;

reg [2:0] state, next_state;
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
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALL);
        digging <= (state == DIG);
        if (state == FALL) begin
            fall_count <= fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALL: begin
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
                next_state = FALL;
            end
        end
        DIG: begin
            if (!ground) begin
                next_state = FALL;
            end
            else begin
                next_state = DIG;
            end
        end
        SPLATTER: begin
            next_state = SPLATTER;
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
