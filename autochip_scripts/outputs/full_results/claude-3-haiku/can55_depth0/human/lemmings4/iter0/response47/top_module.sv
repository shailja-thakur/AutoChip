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

localparam [2:0] WALK_LEFT = 3'b000, WALK_RIGHT = 3'b001, FALLING = 3'b010, DIGGING = 3'b011, SPLATTER = 3'b100;
reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_count <= 5'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALLING);
        digging <= (state == DIGGING);
        if (state == FALLING) begin
            fall_count <= fall_count + 1'b1;
        end
        else begin
            fall_count <= 5'b0;
        end
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALLING;
            else if (dig && ground) next_state = DIGGING;
            else next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALLING;
            else if (dig && ground) next_state = DIGGING;
            else next_state = WALK_RIGHT;
        end
        FALLING: begin
            if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else if (fall_count >= 20) next_state = SPLATTER;
            else next_state = FALLING;
        end
        DIGGING: begin
            if (!ground) next_state = FALLING;
            else next_state = DIGGING;
        end
        SPLATTER: begin
            next_state = SPLATTER;
        end
        default: next_state = WALK_LEFT;
    endcase
end

endmodule
