module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

localparam [1:0] WALK_LEFT = 2'b00,
                 WALK_RIGHT = 2'b01,
                 FALL = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
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

    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            if (ground == 0) begin
                next_state = FALL;
                aaah = 1;
            end
            else if (bump_right) begin
                next_state = WALK_RIGHT;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (ground == 0) begin
                next_state = FALL;
                aaah = 1;
            end
            else if (bump_left) begin
                next_state = WALK_LEFT;
            end
        end
        FALL: begin
            aaah = 1;
            if (ground) begin
                if (walk_left) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

endmodule
