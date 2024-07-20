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

reg [5:0] fall_count; // Counter for tracking the duration of a fall

// Define the states of the Lemming
localparam [1:0] WALK_LEFT = 2'b00,
                 WALK_RIGHT = 2'b01,
                 FALL = 2'b10,
                 DIGGING = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default values
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
                fall_count = 0;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
                fall_count = 0;
            end
            else if (dig) begin
                next_state = DIGGING;
            end
        end
        FALL: begin
            aaah = 1;
            fall_count = fall_count + 1;
            if (ground) begin
                if (fall_count >= 20) begin
                    // Splatter
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                end
                else begin
                    // Resume walking in the same direction
                    if (state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end
                    else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end
        end
        DIGGING: begin
            digging = 1;
            if (!ground) begin
                next_state = FALL;
                fall_count = 0;
            end
            else if (!dig) begin
                // Finished digging, resume walking
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

endmodule
