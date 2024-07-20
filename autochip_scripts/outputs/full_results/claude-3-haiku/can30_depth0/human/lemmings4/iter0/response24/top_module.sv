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
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == FALL) begin
            fall_count <= fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
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
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (~ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = FALL;
                digging = 1;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (~ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = FALL;
                digging = 1;
            end
        end
        FALL: begin
            aaah = 1;
            if (ground) begin
                if (fall_count > 20) begin
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
        end
        SPLATTER: begin
            // Do nothing, Lemming is splattered
        end
    endcase
end

endmodule
