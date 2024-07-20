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

    // State encoding
    typedef enum logic [2:0] {
        WALK_LEFT = 3'd0,
        WALK_RIGHT = 3'd1,
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3,
        DIG_LEFT = 3'd4,
        DIG_RIGHT = 3'd5,
        SPLAT = 3'd6
    } state_t;
    
    state_t state, next_state;
    logic [4:0] fall_counter;

    // State transition and output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;

            // Reset fall counter if hitting ground
            if (ground)
                fall_counter <= 0;
            else if (next_state == FALL_LEFT || next_state == FALL_RIGHT)
                fall_counter <= fall_counter + 1;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case(state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
                walk_left = 1;
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
                walk_right = 1;
            end
            FALL_LEFT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = WALK_LEFT;
                    end
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            DIG_LEFT: begin
                digging = 1;
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else begin
                    next_state = DIG_LEFT;
                end
            end
            DIG_RIGHT: begin
                digging = 1;
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else begin
                    next_state = DIG_RIGHT;
                end
            end
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                next_state = SPLAT;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule
