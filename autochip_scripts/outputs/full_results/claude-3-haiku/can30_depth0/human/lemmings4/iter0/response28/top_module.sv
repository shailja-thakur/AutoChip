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

// States
localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALL = 2;
localparam STATE_DIG = 3;
localparam STATE_SPLATTER = 4;

reg [2:0] state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    state <= STATE_WALK_RIGHT;
                end
                else if (~ground) begin
                    state <= STATE_FALL;
                    fall_count <= 0;
                end
                else if (dig) begin
                    state <= STATE_DIG;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    state <= STATE_WALK_LEFT;
                end
                else if (~ground) begin
                    state <= STATE_FALL;
                    fall_count <= 0;
                end
                else if (dig) begin
                    state <= STATE_DIG;
                end
            end
            STATE_FALL: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1;
                digging <= 0;
                fall_count <= fall_count + 1;
                if (ground) begin
                    if (fall_count >= 20) begin
                        state <= STATE_SPLATTER;
                    end
                    else begin
                        state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    end
                end
            end
            STATE_DIG: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 0;
                digging <= 1;
                if (~ground) begin
                    state <= STATE_FALL;
                    fall_count <= 0;
                end
                else if (dig) begin
                    state <= STATE_WALK_LEFT;
                end
            end
            STATE_SPLATTER: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
