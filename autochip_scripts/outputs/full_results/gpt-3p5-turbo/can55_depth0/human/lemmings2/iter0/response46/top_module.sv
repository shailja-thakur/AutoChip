module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);
    
    // Define the states
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL
    } state_t;

    // Define the current state signal
    state_t current_state;
    
    // Define the next state signal
    state_t next_state;
    
    // Define the output signals
    logic walk_left;
    logic walk_right;
    logic aaah;
    
    // Define internal signals
    logic bump_left_fall;
    logic bump_right_fall;
    logic ground_fall;
    
    // Define the state transition and output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to initial state (WALK_LEFT)
            current_state <= WALK_LEFT;
        end else begin
            // Update the current state based on the next state
            current_state <= next_state;
        end
        
        // Calculate the next state and output signals based on the current state and inputs
        case (current_state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (!ground) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_LEFT;
                end
                
                // Output signals
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (!ground) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_RIGHT;
                end
                
                // Output signals
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            FALL: begin
                if (bump_left) begin
                    bump_left_fall = 1;
                end else begin
                    bump_left_fall = 0;
                end
                
                if (bump_right) begin
                    bump_right_fall = 1;
                end else begin
                    bump_right_fall = 0;
                end
                
                if (ground) begin
                    ground_fall = 1;
                end else begin
                    ground_fall = 0;
                end
                
                if (ground_fall) begin
                    if (bump_left_fall || bump_right_fall) begin
                        next_state = FALL;
                    end else if (walk_left) begin
                        next_state = WALK_LEFT;
                    end else if (walk_right) begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = FALL;
                end
                
                // Output signals
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end
endmodule
