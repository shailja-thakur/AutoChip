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
localparam [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;

reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (~ground) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (~ground) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        FALL: begin
            if (ground) begin
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            end else begin
                next_state = FALL;
            end
        end
        DIG: begin
            if (~ground) begin
                next_state = FALL;
            end else begin
                next_state = DIG;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        FALL: begin
            walk_left = walk_left;
            walk_right = walk_right;
            aaah = 1;
            digging = 0;
        end
        DIG: begin
            walk_left = walk_left;
            walk_right = walk_right;
            aaah = 0;
            digging = 1;
        end
    endcase
end

// State update
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

endmodule
