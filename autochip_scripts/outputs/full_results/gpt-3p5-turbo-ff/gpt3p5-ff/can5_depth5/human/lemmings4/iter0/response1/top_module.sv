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

reg [4:0] state;

parameter WALK_LEFT = 3'b001;
parameter WALK_RIGHT = 3'b010;
parameter FALL = 3'b011;
parameter DIG = 3'b100;
parameter SPLATTER = 3'b101;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case(state)
            WALK_LEFT:
                if (bump_left && !bump_right)
                    state <= WALK_RIGHT;
                else if (bump_left && bump_right)
                    state <= WALK_RIGHT;
                else if (!bump_left && bump_right)
                    state <= WALK_LEFT;
                else if (dig && ground)
                    state <= DIG;
                else if (!ground)
                    state <= FALL;
                else
                    state <= WALK_LEFT;
            WALK_RIGHT:
                if (!bump_left && bump_right)
                    state <= WALK_LEFT;
                else if (bump_left && bump_right)
                    state <= WALK_LEFT;
                else if (bump_left && !bump_right)
                    state <= WALK_RIGHT;
                else if (dig && ground)
                    state <= DIG;
                else if (!ground)
                    state <= FALL;
                else
                    state <= WALK_RIGHT;
            FALL:
                if (ground)
                    state <= state;
                else
                    state <= FALL;
            DIG:
                if (dig && !ground)
                    state <= state;
                else if (ground)
                    state <= WALK_LEFT;
                else
                    state <= DIG;
            SPLATTER:
                state <= SPLATTER;
        endcase
    end
end

always @(state) begin
    case(state)
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
        DIG:
            begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
        SPLATTER:
            begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
    endcase
end


endmodule
