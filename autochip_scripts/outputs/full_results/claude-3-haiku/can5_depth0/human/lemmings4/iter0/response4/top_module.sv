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
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == S_WALK_LEFT) ? 1 : 0;
        walk_right <= (state == S_WALK_RIGHT) ? 1 : 0;
        aaah <= (state == S_FALL) ? 1 : 0;
        digging <= (state == S_DIG) ? 1 : 0;
        if (state == S_FALL) begin
            fall_counter <= fall_counter + 1;
        end
        else begin
            fall_counter <= 0;
        end
    end
end

always @(*) begin
    case (state)
        S_WALK_LEFT: begin
            if (bump_right) begin
                next_state = S_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = S_FALL;
            end
            else if (dig && ground) begin
                next_state = S_DIG;
            end
            else begin
                next_state = S_WALK_LEFT;
            end
        end
        S_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = S_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = S_FALL;
            end
            else if (dig && ground) begin
                next_state = S_DIG;
            end
            else begin
                next_state = S_WALK_RIGHT;
            end
        end
        S_FALL: begin
            if (ground) begin
                if (fall_counter >= 20) begin
                    next_state = S_WALK_LEFT;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                else begin
                    if (walk_left) begin
                        next_state = S_WALK_LEFT;
                    end
                    else begin
                        next_state = S_WALK_RIGHT;
                    end
                end
            end
            else begin
                next_state = S_FALL;
            end
        end
        S_DIG: begin
            if (!ground) begin
                next_state = S_FALL;
            end
            else begin
                next_state = S_DIG;
            end
        end
        default: begin
            next_state = S_WALK_LEFT;
        end
    endcase
end

endmodule
