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

    typedef enum logic [2:0] {
        WALK_LEFT   = 3'b000,
        WALK_RIGHT  = 3'b001,
        FALL_LEFT   = 3'b010,
        FALL_RIGHT  = 3'b011,
        DIG_LEFT    = 3'b100,
        DIG_RIGHT   = 3'b101,
        SPLATTER    = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 5'b0;
        end else begin
            state <= next_state;
            
            if (aaah)
                fall_count <= fall_count + 1;
            else
                fall_count <= 5'b0;
        end
    end

    always_comb begin
        next_state = state; // Default to no state change
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        
        case (state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || (bump_left && bump_right))
                    next_state = WALK_RIGHT;
            end
                        
            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right || (bump_left && bump_right))
                    next_state = WALK_LEFT;
            end
                        
            FALL_LEFT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_count >= 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_LEFT;
                end
            end
                        
            FALL_RIGHT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_count >= 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_RIGHT;
                end
            end
                        
            DIG_LEFT: begin
                digging = 1'b1;
                if (!ground)
                    next_state = FALL_LEFT;
            end
                        
            DIG_RIGHT: begin
                digging = 1'b1;
                if (!ground)
                    next_state = FALL_RIGHT;
            end
                        
            SPLATTER: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
                        
            default: next_state = WALK_LEFT;
        endcase
    end
endmodule
