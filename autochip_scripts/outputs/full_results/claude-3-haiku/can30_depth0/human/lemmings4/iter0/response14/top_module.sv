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

localparam [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, SPLATTER = 2'b11;
reg [1:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_counter <= 5'b0;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        state <= next_state;
        fall_counter <= (state == FALL) ? fall_counter + 1'b1 : 5'b0;
        walk_left <= (state == WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right <= (state == WALK_RIGHT) ? 1'b1 : 1'b0;
        aaah <= (state == FALL) ? 1'b1 : 1'b0;
        digging <= (state == WALK_LEFT && dig) || (state == WALK_RIGHT && dig) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALL;
            else if (dig && ground) next_state = WALK_LEFT;
            else next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALL;
            else if (dig && ground) next_state = WALK_RIGHT;
            else next_state = WALK_RIGHT;
        end
        FALL: begin
            if (ground) next_state = (fall_counter >= 20) ? SPLATTER : ((walk_left) ? WALK_LEFT : WALK_RIGHT);
            else next_state = FALL;
        end
        SPLATTER: begin
            next_state = SPLATTER;
        end
        default: next_state = WALK_LEFT;
    endcase
end

endmodule
