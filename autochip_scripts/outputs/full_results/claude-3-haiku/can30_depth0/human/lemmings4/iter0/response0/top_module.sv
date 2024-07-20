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

localparam [2:0] 
    STATE_WALK_LEFT = 3'b000,
    STATE_WALK_RIGHT = 3'b001,
    STATE_FALLING = 3'b010,
    STATE_DIGGING = 3'b011,
    STATE_SPLATTER = 3'b100;

reg [2:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_counter <= 5'b0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_counter <= 5'b0;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_counter <= 5'b0;
            end
            STATE_FALLING: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
                fall_counter <= fall_counter + 1'b1;
            end
            STATE_DIGGING: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b1;
                fall_counter <= 5'b0;
            end
            STATE_SPLATTER: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_counter <= 5'b0;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) next_state = STATE_WALK_RIGHT;
            else if (!ground) next_state = STATE_FALLING;
            else if (dig && ground) next_state = STATE_DIGGING;
            else next_state = STATE_WALK_LEFT;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) next_state = STATE_WALK_LEFT;
            else if (!ground) next_state = STATE_FALLING;
            else if (dig && ground) next_state = STATE_DIGGING;
            else next_state = STATE_WALK_RIGHT;
        end
        STATE_FALLING: begin
            if (ground) next_state = STATE_WALK_LEFT; // Lemming resumes walking in original direction
            else if (fall_counter >= 20 && !ground) next_state = STATE_SPLATTER;
            else next_state = STATE_FALLING;
        end
        STATE_DIGGING: begin
            if (!ground) next_state = STATE_FALLING; // Lemming falls when it reaches the other side
            else next_state = STATE_DIGGING;
        end
        STATE_SPLATTER: begin
            next_state = STATE_SPLATTER;
        end
    endcase
end

endmodule
