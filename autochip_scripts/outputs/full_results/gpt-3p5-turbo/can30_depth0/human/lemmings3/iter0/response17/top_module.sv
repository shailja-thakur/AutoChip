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

reg [1:0] state; // current state
reg prev_ground; // previous ground state

// Define states
parameter IDLE = 2'b00; // Idle state
parameter WALK_RIGHT = 2'b01; // Walking right state
parameter WALK_LEFT = 2'b10; // Walking left state

always@(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE; // Reset state to IDLE on areset
        prev_ground <= ground; // Set previous ground state
        walk_left <= 1; // Start with initial direction as left
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        prev_ground <= ground; // Update previous ground state

        // State transition logic
        case (state)
            IDLE: begin
                if (bump_left && !bump_right && prev_ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
                else if (!bump_left && bump_right && prev_ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
                else if (bump_left && bump_right && prev_ground) begin
                    if (walk_left) begin
                        state <= WALK_RIGHT;
                        walk_left <= 0;
                        walk_right <= 1;
                    end
                    else begin
                        state <= WALK_LEFT;
                        walk_left <= 1;
                        walk_right <= 0;
                    end
                end
                else if (dig && prev_ground) begin
                    state <= IDLE;
                    aaah <= 0;
                    digging <= 1;
                end
            end

            WALK_RIGHT: begin
                if (bump_left && !bump_right && prev_ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
                else if (bump_left && bump_right && prev_ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
                else if (dig && prev_ground) begin
                    state <= IDLE;
                    aaah <= 0;
                    digging <= 1;
                end
                else if (!prev_ground && ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
                else if (!ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 1;
                    digging <= 0;
                end
            end

            WALK_LEFT: begin
                if (!bump_left && bump_right && prev_ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
                else if (bump_left && bump_right && prev_ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
                else if (dig && prev_ground) begin
                    state <= IDLE;
                    aaah <= 0;
                    digging <= 1;
                end
                else if (!prev_ground && ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
                else if (!ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
            end

        endcase
    end
end

endmodule
