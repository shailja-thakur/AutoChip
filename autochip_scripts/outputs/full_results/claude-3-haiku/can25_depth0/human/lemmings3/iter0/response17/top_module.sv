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
localparam [1:0] WALKING_LEFT = 2'b00,
                 WALKING_RIGHT = 2'b01,
                 FALLING = 2'b10,
                 DIGGING = 2'b11;

// Current state register
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALKING_LEFT: begin
            walk_left = 1;
            if (ground) begin
                if (bump_right) begin
                    next_state = WALKING_RIGHT;
                end
                else begin
                    next_state = WALKING_LEFT;
                end
            end
            else begin
                next_state = FALLING;
                aaah = 1;
            end
            if (dig && ground) begin
                next_state = DIGGING;
                digging = 1;
            end
        end
        WALKING_RIGHT: begin
            walk_right = 1;
            if (ground) begin
                if (bump_left) begin
                    next_state = WALKING_LEFT;
                end
                else begin
                    next_state = WALKING_RIGHT;
                end
            end
            else begin
                next_state = FALLING;
                aaah = 1;
            end
            if (dig && ground) begin
                next_state = DIGGING;
                digging = 1;
            end
        end
        FALLING: begin
            aaah = 1;
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
            digging = 1;
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
                aaah = 1;
            end
        end
        default: begin
            next_state = WALKING_LEFT;
        end
    endcase
end

endmodule
