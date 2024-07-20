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
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
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
                next_state = FALLING;
                fall_counter = 1;
            end
            else if (dig && ground) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (~ground) begin
                next_state = FALLING;
                fall_counter = 1;
            end
            else if (dig && ground) begin
                next_state = DIGGING;
            end
        end
        FALLING: begin
            aaah = 1;
            fall_counter = fall_counter + 1;
            if (ground) begin
                if (fall_counter > 20) begin
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
                fall_counter = 0;
            end
        end
        DIGGING: begin
            digging = 1;
            if (~ground) begin
                next_state = FALLING;
                fall_counter = 1;
            end
        end
        SPLATTER: begin
            // do nothing
        end
    endcase
end

endmodule
