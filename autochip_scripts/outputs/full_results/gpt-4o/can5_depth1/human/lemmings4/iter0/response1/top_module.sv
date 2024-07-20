module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    // State definition
    typedef enum logic [2:0] {
        S_WALK_LEFT,
        S_WALK_RIGHT,
        S_FALL,
        S_DIG_LEFT,
        S_DIG_RIGHT,
        S_SPLATTER
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter; // To count fall cycles
  
    // State Logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == S_FALL)
                fall_counter <= fall_counter + 5'd1;
            else
                fall_counter <= 5'd0;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            S_WALK_LEFT: begin
                if (!ground) next_state = S_FALL;
                else if (dig) next_state = S_DIG_LEFT;
                else if (bump_left) next_state = S_WALK_RIGHT;
            end
            S_WALK_RIGHT: begin
                if (!ground) next_state = S_FALL;
                else if (dig) next_state = S_DIG_RIGHT;
                else if (bump_right) next_state = S_WALK_LEFT;
            end
            S_FALL: begin
                if (ground) begin
                    if (fall_counter > 5'd20) 
                        next_state = S_SPLATTER;
                    else begin
                        if (state == S_WALK_LEFT || state == S_DIG_LEFT) 
                            next_state = S_WALK_LEFT;
                        else 
                            next_state = S_WALK_RIGHT;
                    end
                end
            end
            S_DIG_LEFT: begin
                if (!ground) next_state = S_FALL;
            end
            S_DIG_RIGHT: begin
                if (!ground) next_state = S_FALL;
            end
            S_SPLATTER: begin
                // State remains the same
            end
            default: next_state = S_WALK_LEFT; // Covers unknown states
        endcase
    end

    // Output logic
    assign walk_left = (state == S_WALK_LEFT);
    assign walk_right = (state == S_WALK_RIGHT);
    assign aaah = (state == S_FALL);
    assign digging = (state == S_DIG_LEFT || state == S_DIG_RIGHT);

endmodule
