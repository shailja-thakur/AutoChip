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

// Define the states
parameter WALK_LEFT = 0, WALK_RIGHT = 1, FALL = 2, DIG = 3;
reg [1:0] state, next_state;

// Define the counter for the fall duration
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        
        // Update the outputs based on the current state
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                fall_count <= fall_count + 1;
            end
            DIG: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                fall_count <= 0;
            end
        endcase
    end
end

// Define the next state logic
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALL;
            else if (dig && ground) next_state = DIG;
            else next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALL;
            else if (dig && ground) next_state = DIG;
            else next_state = WALK_RIGHT;
        end
        FALL: begin
            if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else next_state = FALL;
        end
        DIG: begin
            if (!ground) next_state = FALL;
            else next_state = DIG;
        end
    endcase
    
    // Splatter condition
    if (fall_count >= 20 && !ground) begin
        next_state = WALK_LEFT; // Reset the state to walk left
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
end

endmodule
