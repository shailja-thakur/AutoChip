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
        S_WL,        // Walk Left
        S_WR,        // Walk Right
        S_FALL_L,    // Fall while walking left
        S_FALL_R,    // Fall while walking right
        S_DIG_L,     // Dig while walking left
        S_DIG_R,     // Dig while walking right
        S_SPLAT      // Splat
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count;
    
    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WL;
            fall_count <= 0;
        end
        else begin
            state <= next_state;
            if (state == S_FALL_L || state == S_FALL_R) 
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            S_WL: begin
                if (!ground) 
                    next_state = S_FALL_L;
                else if (dig) 
                    next_state = S_DIG_L;
                else if (bump_left)
                    next_state = S_WR;
            end
            
            S_WR: begin
                if (!ground)
                    next_state = S_FALL_R;
                else if (dig)
                    next_state = S_DIG_R;
                else if (bump_right)
                    next_state = S_WL;
            end
            
            S_FALL_L: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = S_SPLAT;
                    else
                        next_state = S_WL;
                end
            end
            
            S_FALL_R: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = S_SPLAT;
                    else
                        next_state = S_WR;
                end
            end
            
            S_DIG_L: begin
                if (!ground)
                    next_state = S_FALL_L;
            end
            
            S_DIG_R: begin
                if (!ground)
                    next_state = S_FALL_R;
            end
            
            S_SPLAT: begin
                next_state = S_SPLAT; // Stays in splat state
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            S_WL: walk_left = 1;
            S_WR: walk_right = 1;
            S_FALL_L, S_FALL_R: aaah = 1;
            S_DIG_L: digging = 1;
            S_DIG_R: digging = 1;
            S_SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
