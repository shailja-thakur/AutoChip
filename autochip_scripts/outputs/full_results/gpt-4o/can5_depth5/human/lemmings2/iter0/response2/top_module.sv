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
    // Define states
    typedef enum logic [2:0] {
        LEFT    = 3'b001,
        RIGHT   = 3'b010,
        FALLING = 3'b100
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALLING: begin
                if (ground) begin
                    if (walk_left) 
                        next_state = LEFT;
                    else 
                        next_state = RIGHT;
                end else begin
                    next_state = FALLING;
                end
            end
            default: next_state = LEFT;
        endcase
    end
    
    // State register logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            FALLING: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
        endcase
    end
    
endmodule
