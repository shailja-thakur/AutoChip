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

// State encoding
typedef enum logic [3:0] {
    WALK_LEFT     = 4'b0001,
    WALK_RIGHT    = 4'b0010,
    FALL_LEFT     = 4'b0100,
    FALL_RIGHT    = 4'b1000,
    DIG_LEFT      = 4'b0001,
    DIG_RIGHT     = 4'b0010
} states_t;

states_t current_state, next_state;
reg aaah_reg, digging_reg;

// Sequential state transition
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        aaah_reg <= 0;
        digging_reg <= 0;
    end
    else begin
        current_state <= next_state;
        aaah_reg <= (next_state == FALL_LEFT || next_state == FALL_RIGHT);
        digging_reg <= (next_state == DIG_LEFT || next_state == DIG_RIGHT);
    end
end

// Combinatorial next state logic
always_comb begin
    next_state = current_state;
    case (current_state)
    
        WALK_LEFT: begin
            if (!ground)
                next_state = FALL_LEFT;
            else if (dig)
                next_state = DIG_LEFT;
            else if (bump_left)
                next_state = WALK_RIGHT;
        end
        
        WALK_RIGHT: begin
            if (!ground)
                next_state = FALL_RIGHT;
            else if (dig)
                next_state = DIG_RIGHT;
            else if (bump_right)
                next_state = WALK_LEFT;
        end
        
        FALL_LEFT: begin
            if (ground)
                next_state = WALK_LEFT;
        end
        
        FALL_RIGHT: begin
            if (ground)
                next_state = WALK_RIGHT;
        end
        
        DIG_LEFT: begin
            if (!ground)
                next_state = FALL_LEFT;
        end
        
        DIG_RIGHT: begin
            if (!ground)
                next_state = FALL_RIGHT;
        end
        
        default: next_state = WALK_LEFT;
        
    endcase
end

// Output logic
assign walk_left  = (current_state == WALK_LEFT);
assign walk_right = (current_state == WALK_RIGHT);
assign aaah       = aaah_reg;
assign digging    = digging_reg;

endmodule
