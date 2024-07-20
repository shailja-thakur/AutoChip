module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum reg [2:0] {
        S_IDLE = 3'b000,     // Initial state
        S_ONE = 3'b001,      // 1
        S_TWO = 3'b010,      // 11
        S_THREE = 3'b011,    // 111
        S_FOUR = 3'b100,     // 1111
        S_FIVE = 3'b101,     // 11111
        S_SIX = 3'b110,      // 111111
        S_SEVEN = 3'b111     // 1111111 (Error state)
    } state_t;
    
    state_t current_state, next_state;
    
    // Next state logic
    always @(*) begin
        // Default values for output signals
        disc = 0;
        flag = 0;
        err = 0;
        
        case (current_state)
            S_IDLE: begin
                if (in)
                    next_state = S_ONE;
                else
                    next_state = S_IDLE;
            end
            
            S_ONE: begin
                if (in)
                    next_state = S_TWO;
                else
                    next_state = S_IDLE;
            end
            
            S_TWO: begin
                if (in)
                    next_state = S_THREE;
                else
                    next_state = S_IDLE;
            end
            
            S_THREE: begin
                if (in)
                    next_state = S_FOUR;
                else
                    next_state = S_IDLE;
            end
            
            S_FOUR: begin
                if (in)
                    next_state = S_FIVE;
                else
                    next_state = S_IDLE;
            end
            
            S_FIVE: begin
                if (in)
                    next_state = S_SIX;
                else
                    next_state = S_IDLE;
            end
            
            S_SIX: begin
                if (in) begin
                    next_state = S_SEVEN;
                    err = 1;
                end else
                    next_state = S_IDLE;
                flag = 1;
            end
            
            S_SEVEN: begin
                if (in)
                    next_state = S_SEVEN;
                else
                    next_state = S_IDLE;
                flag = 1;
                err = 1;
            end
            
            default: next_state = S_IDLE;
        endcase
    end
    
    // State transition on clock edge
    always @(posedge clk) begin
        if (reset)
            current_state = S_IDLE;
        else
            current_state = next_state;
    end
    
    // Output logic for discarding
    always @(posedge clk) begin
        if (reset)
            disc <= 0;
        else if (current_state == S_SIX && in == 1'b0)
            disc <= 1;
        else
            disc <= 0;
    end

endmodule
