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
    typedef enum reg [2:0] {
        LEFT = 3'b001,
        RIGHT = 3'b010,
        FALLING_LEFT = 3'b011,
        FALLING_RIGHT = 3'b100,
        AA = 3'b000
    } state_t;
    
    state_t current_state, next_state;

    // State transition
    always @(*) begin
        case (current_state)
            LEFT: begin
                if (!ground) next_state = FALLING_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALLING_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALLING_LEFT: begin
                if (ground) next_state = LEFT;
                else next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground) next_state = RIGHT;
                else next_state = FALLING_RIGHT;
            end
            default: next_state = LEFT;  // To handle unexpected states
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        
        case (current_state)
            LEFT: begin
                walk_left = 1;
            end
            RIGHT: begin
                walk_right = 1;
            end
            FALLING_LEFT, FALLING_RIGHT: begin
                aaah = 1;
            end
        endcase
    end
    
endmodule
