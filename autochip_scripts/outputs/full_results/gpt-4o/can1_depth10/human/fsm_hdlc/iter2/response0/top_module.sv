module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    parameter IDLE   = 3'd0, 
              ONE    = 3'd1, 
              TWO    = 3'd2, 
              THREE  = 3'd3, 
              FOUR   = 3'd4, 
              FIVE   = 3'd5, 
              SIX    = 3'd6, 
              SEVEN  = 3'd7;

    reg [2:0] state, next_state;
    
    // Sequential logic: state transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Combinational logic: next state logic
    always @(*) begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;
        
        next_state = state;  // Default to hold current state

        case (state)
            IDLE: 
                next_state = in ? ONE : IDLE;
            ONE: 
                next_state = in ? TWO : IDLE;
            TWO: 
                next_state = in ? THREE : IDLE;
            THREE: 
                next_state = in ? FOUR : IDLE;
            FOUR: 
                next_state = in ? FIVE : IDLE;
            FIVE: 
                next_state = in ? SIX : IDLE;
            SIX: begin
                if (in) 
                    next_state = SEVEN;
                else begin
                    next_state = IDLE;
                end
            end
            SEVEN: begin
                if (in)
                    next_state = SEVEN;  // Stay in error state if input remains high
                else
                    next_state = IDLE;
                    err = 1;  // Error: 01111111 (7 consecutive 1s detected)
            end
            default: 
                next_state = IDLE;
        endcase

        case (state)
            IDLE: begin
                disc = 0;
                flag = 0;
                err = 0;
            end
            ONE, TWO, THREE, FOUR, FIVE: 
                begin
                // No outputs in these states
                end
            SIX: begin
                if (!in) 
                    disc = 1;  // 0111110 pattern detected
                else 
                    flag = 1;  // 01111110 pattern detected
            end
            SEVEN: begin
                if (!in)
                    err = 1;  // Error: 01111111 (7 consecutive 1s detected)
            end
        endcase
    end
endmodule
