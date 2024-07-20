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
                 FALLING = 3'b010,
                 DIGGING = 3'b011,
                 SPLATTER = 3'b100;

reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
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
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) next_state = WALK_RIGHT;
            else if (~ground) next_state = FALLING;
            else if (dig && ground) next_state = DIGGING;
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) next_state = WALK_LEFT;
            else if (~ground) next_state = FALLING;
            else if (dig && ground) next_state = DIGGING;
        end
        FALLING: begin
            aaah = 1;
            if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else if (fall_count > 20) next_state = SPLATTER;
        end
        DIGGING: begin
            digging = 1;
            if (~ground) next_state = FALLING;
            else if (dig && ground) next_state = WALK_LEFT;
        end
        SPLATTER: begin
            // Do nothing
        end
    endcase
end

endmodule
