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

    // Define states
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;
    
    // Define signals for state and next state
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;  // Reset to walk left state
        end else begin
            state <= next_state;  // Update state to next_state
        end
    end
    
    always @(*) begin
        // Default next state is the current state
        next_state = state;
        
        // Determine next state based on current state and inputs
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (bump_left || (bump_left && bump_right)) begin
                    next_state = WALK_LEFT;
                end else if (!ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (bump_right || (bump_left && bump_right)) begin
                    next_state = WALK_RIGHT;
                end else if (!ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end
            end
            FALL: begin
                if (ground) begin
                    if (state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else if (state == WALK_RIGHT) begin
                        next_state = WALK_RIGHT;
                    end
                end
            end
            DIG: begin
                if (!ground) begin
                    next_state = FALL;
                end
            end
        endcase
    end
    
    // Outputs
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);
    
endmodule
