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

// Define the states
parameter WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;

// Current state and next state
reg [1:0] current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        current_state <= next_state;
        walk_left <= (current_state == WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right <= (current_state == WALK_RIGHT) ? 1'b1 : 1'b0;
        aaah <= (current_state == FALL) ? 1'b1 : 1'b0;
        digging <= (current_state == DIG) ? 1'b1 : 1'b0;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig) begin
                next_state = DIG;
            end
            else begin
                next_state = WALK_RIGHT;
            end
        end
        FALL: begin
            if (ground) begin
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            end
            else begin
                next_state = FALL;
            end
        end
        DIG: begin
            if (!ground) begin
                next_state = FALL;
            end
            else begin
                next_state = DIG;
            end
        end
        default: begin
            next_state = WALK_LEFT;
        end
    endcase
end

endmodule
