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

localparam S_WALK_LEFT = 2'b00;
localparam S_WALK_RIGHT = 2'b01;
localparam S_FALL = 2'b10;
localparam S_DIG = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S_WALK_LEFT;
        fall_count <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        if (state == S_FALL) begin
            fall_count <= fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        S_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right) begin
                next_state = S_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = S_FALL;
            end
            else if (dig && ground) begin
                next_state = S_DIG;
            end
        end
        S_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left) begin
                next_state = S_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = S_FALL;
            end
            else if (dig && ground) begin
                next_state = S_DIG;
            end
        end
        S_FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            if (ground) begin
                next_state = (walk_left) ? S_WALK_LEFT : S_WALK_RIGHT;
            end
            else if (fall_count == 20) begin
                next_state = S_WALK_LEFT;
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
            end
        end
        S_DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
            if (!ground) begin
                next_state = S_FALL;
            end
            else if (ground) begin
                next_state = (walk_left) ? S_WALK_LEFT : S_WALK_RIGHT;
            end
        end
    endcase
end

endmodule
