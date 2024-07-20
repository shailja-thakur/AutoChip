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
parameter WALKING_LEFT = 2'b00;
parameter WALKING_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter DIGGING = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default values
    walk_left = 1'b0;
    walk_right = 1'b0;
    aaah = 1'b0;
    digging = 1'b0;

    case (state)
        WALKING_LEFT: begin
            walk_left = 1'b1;
            if (bump_right) begin
                next_state = WALKING_RIGHT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALKING_LEFT;
            end
        end
        WALKING_RIGHT: begin
            walk_right = 1'b1;
            if (bump_left) begin
                next_state = WALKING_LEFT;
            end
            else if (!ground) begin
                next_state = FALLING;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
            else begin
                next_state = WALKING_RIGHT;
            end
        end
        FALLING: begin
            aaah = 1'b1;
            if (ground) begin
                if (walk_left) begin
                    next_state = WALKING_LEFT;
                end
                else begin
                    next_state = WALKING_RIGHT;
                end
            end
            else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            digging = 1'b1;
            if (!ground) begin
                next_state = FALLING;
            end
            else begin
                next_state = DIGGING;
            end
        end
        default: begin
            next_state = WALKING_LEFT;
        end
    endcase
end

endmodule
