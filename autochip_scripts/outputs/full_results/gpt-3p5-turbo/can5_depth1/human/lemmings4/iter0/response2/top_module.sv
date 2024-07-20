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

// Define states
parameter [2:0] WALK_LEFT = 3'b000;
parameter [2:0] WALK_RIGHT = 3'b001;
parameter [2:0] FALL_LEFT = 3'b010;
parameter [2:0] FALL_RIGHT = 3'b011;
parameter [2:0] DIG = 3'b100;
parameter [2:0] SPLATTER = 3'b101;

// Define internal signals
reg [2:0] state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else begin
        case (state)
            WALK_LEFT:
                if (bump_right && !bump_left)
                    state <= WALK_RIGHT;
                else if (!ground)
                    state <= FALL_LEFT;
                else if (dig)
                    state <= DIG;
                else
                    state <= WALK_LEFT;
            WALK_RIGHT:
                if (!bump_right && bump_left)
                    state <= WALK_LEFT;
                else if (!ground)
                    state <= FALL_RIGHT;
                else if (dig)
                    state <= DIG;
                else
                    state <= WALK_RIGHT;
            FALL_LEFT:
                if (ground)
                    state <= WALK_LEFT;
                else if (dig)
                    state <= DIG;
                else
                    state <= FALL_LEFT;
            FALL_RIGHT:
                if (ground)
                    state <= WALK_RIGHT;
                else if (dig)
                    state <= DIG;
                else
                    state <= FALL_RIGHT;
            DIG:
                if (!ground)
                    state <= FALL_LEFT;
                else if (fall_count >= 5'b100000)
                    state <= SPLATTER;
                else if (!dig)
                    state <= WALK_LEFT;
                else
                    state <= DIG;
            SPLATTER:
                state <= SPLATTER;
        endcase
    end
end

always @(posedge clk or posedge areset) begin
    if (areset)
        fall_count <= 5'b00000;
    else begin
        case (state)
            FALL_LEFT, FALL_RIGHT:
                if (!fall_count[4] && ground)
                    fall_count <= fall_count + 1;
                else
                    fall_count <= 5'b00000;
            default:
                fall_count <= 5'b00000;
        endcase
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        walking_left <= 1'b1;
        walking_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        case (state)
            WALK_LEFT:
                walking_left <= 1'b1;
                walking_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            WALK_RIGHT:
                walking_left <= 1'b0;
                walking_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
            FALL_LEFT, FALL_RIGHT:
                walking_left <= 1'b0;
                walking_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
            DIG:
                walking_left <= 1'b0;
                walking_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b1;
            SPLATTER:
                walking_left <= 1'b0;
                walking_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
        endcase
    end
end

endmodule
