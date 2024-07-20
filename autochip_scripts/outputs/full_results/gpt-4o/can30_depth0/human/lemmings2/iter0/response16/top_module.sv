module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    // State encoding
    typedef enum logic [1:0] {
        LEFT = 2'b00,        // Walking left
        RIGHT = 2'b01,       // Walking right
        FALL_LEFT = 2'b10,   // Falling while previously walking left
        FALL_RIGHT = 2'b11   // Falling while previously walking right
    } state_t;
    
    state_t state, next_state;
    
    // Next state logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left || (bump_left && bump_right)) begin
                    next_state = RIGHT;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = LEFT;
                end
            end
            
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_right || (bump_right && bump_left)) begin
                    next_state = LEFT;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = RIGHT;
                end
            end
    
            FALL_LEFT: begin
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
    
            default: next_state = LEFT; // Safety default state
        endcase
    end
    
    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == FALL_LEFT || state == FALL_RIGHT);
    end

endmodule
