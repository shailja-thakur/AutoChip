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

localparam STATE_WALK_LEFT = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALL = 2'b10;
localparam STATE_DIG = 2'b11;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end else if (dig) begin
                next_state = STATE_DIG;
            end else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end else if (!ground) begin
                next_state = STATE_FALL;
            end else if (dig) begin
                next_state = STATE_DIG;
            end else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALL: begin
            if (ground) begin
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end else begin
                next_state = STATE_FALL;
            end
        end
        STATE_DIG: begin
            if (!ground) begin
                next_state = STATE_FALL;
            end else begin
                next_state = STATE_DIG;
            end
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

// State output logic
always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            digging = 1'b0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
            digging = 1'b0;
        end
        STATE_FALL: begin
            walk_left = walk_left;
            walk_right = walk_right;
            aaah = 1'b1;
            digging = 1'b0;
        end
        STATE_DIG: begin
            walk_left = walk_left;
            walk_right = walk_right;
            aaah = 1'b0;
            digging = 1'b1;
        end
        default: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            digging = 1'b0;
        end
    endcase
end

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

endmodule
