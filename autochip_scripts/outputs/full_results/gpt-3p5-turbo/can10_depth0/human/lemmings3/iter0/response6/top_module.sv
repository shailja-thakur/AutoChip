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

reg [1:0] state, next_state;

localparam WALK_LEFT = 2'b00;
localparam WALK_RIGHT = 2'b01;
localparam FALL = 2'b10;
localparam DIG = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always @(state or bump_left or bump_right or ground or dig) begin
    case (state)
        WALK_LEFT: begin
            if (ground == 0) begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
                next_state = FALL;
            end else if (bump_left == 1) begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
                next_state = WALK_RIGHT;
            end else begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (ground == 0) begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
                next_state = FALL;
            end else if (bump_right == 1) begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                next_state = WALK_LEFT;
            end else begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
                next_state = WALK_RIGHT;
            end
        end
        FALL: begin
            if (ground == 1) begin
                if (state == WALK_LEFT) begin
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                    next_state = WALK_LEFT;
                end else begin
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                    digging = 0;
                    next_state = WALK_RIGHT;
                end
            end else begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
                next_state = FALL;
            end
        end
        DIG: begin
            if ((state == WALK_LEFT || state == WALK_RIGHT) && ground == 1 && dig == 1) begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
                next_state = DIG;
            end else if (ground == 0) begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
                next_state = FALL;
            end else begin
                if (state == WALK_LEFT) begin
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                    next_state = WALK_LEFT;
                end else begin
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                    digging = 0;
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

endmodule
