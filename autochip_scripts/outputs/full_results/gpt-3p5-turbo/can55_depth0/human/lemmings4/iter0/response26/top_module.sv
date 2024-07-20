module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

reg [2:0] state;

parameter WALK_LEFT = 3'b001;
parameter WALK_RIGHT = 3'b010;
parameter FALL = 3'b100;

always@(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else begin
        case (state)
            WALK_LEFT:
                if (bump_right)
                    state <= WALK_RIGHT;
                else if (bump_left)
                    state <= WALK_LEFT;
                else if (dig && ground)
                    state <= FALL;
            WALK_RIGHT:
                if (bump_left)
                    state <= WALK_LEFT;
                else if (bump_right)
                    state <= WALK_RIGHT;
                else if (dig && ground)
                    state <= FALL;
            FALL:
                if (ground)
                    state <= WALK_LEFT;
        endcase
    end
end

always@(state) begin
    case (state)
        WALK_LEFT:
            begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        WALK_RIGHT:
            begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
        FALL:
            begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end
    endcase
end

endmodule
