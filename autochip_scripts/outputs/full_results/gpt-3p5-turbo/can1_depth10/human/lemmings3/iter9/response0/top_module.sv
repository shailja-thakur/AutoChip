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

reg [1:0] state;
reg falling;

// State definitions
parameter S_IDLE = 2'b00;
parameter S_WALK_LEFT = 2'b01;
parameter S_WALK_RIGHT = 2'b10;
parameter S_FALL = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S_IDLE;
        falling <= 1'b0;
    end else begin
        case (state)
            S_IDLE: begin
                if (dig && ground && !falling) begin
                    state <= S_FALL;
                end else if (dig && !ground && !falling) begin
                    state <= S_FALL;
                end else if (bump_left && !bump_right && ground) begin
                    state <= S_WALK_RIGHT;
                end else if (bump_right && !bump_left && ground) begin
                    state <= S_WALK_LEFT;
                end else if (!ground && !falling) begin
                    state <= S_FALL;
                end
            end
            S_WALK_LEFT: begin
                if (dig && ground && !falling) begin
                    state <= S_FALL;
                end else if (dig && !ground && !falling) begin
                    state <= S_FALL;
                end else if (!ground && !falling) begin
                    state <= S_FALL;
                end else if (bump_left && !bump_right && ground) begin
                    state <= S_WALK_RIGHT;
                end
            end
            S_WALK_RIGHT: begin
                if (dig && ground && !falling) begin
                    state <= S_FALL;
                end else if (dig && !ground && !falling) begin
                    state <= S_FALL;
                end else if (!ground && !falling) begin
                    state <= S_FALL;
                end else if (bump_right && !bump_left && ground) begin
                    state <= S_WALK_LEFT;
                end
            end
            S_FALL: begin
                if (dig && ground && !falling) begin
                    state <= S_FALL;
                end else if (dig && ground && falling) begin
                    state <= S_FALL;
                end else if (dig && !ground && falling) begin
                    state <= S_FALL;
                end else if (ground && !falling) begin
                    state <= S_IDLE;
                end else if (!ground && falling) begin
                    state <= S_FALL;
                end
            end
        endcase
    end
end

always @* begin
    case (state)
        S_IDLE: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
        end
        S_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
        end
        S_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
        end
        S_FALL: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b1;
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b0;
        end
    endcase
end

assign digging = dig & ground;

endmodule
