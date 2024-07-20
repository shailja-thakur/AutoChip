module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // Define states
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        ONE = 3'b001,
        TWO = 3'b010,
        THREE = 3'b011,
        FOUR = 3'b100,
        FIVE = 3'b101,
        SIX = 3'b110,
        SEVEN = 3'b111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        // Default transitions
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (state)
            IDLE: 
                if (in) 
                    next_state = ONE;
                else 
                    next_state = IDLE;
                    
            ONE: 
                if (in) 
                    next_state = TWO;
                else 
                    next_state = IDLE;
                    
            TWO: 
                if (in) 
                    next_state = THREE;
                else 
                    next_state = IDLE;
                    
            THREE: 
                if (in) 
                    next_state = FOUR;
                else 
                    next_state = IDLE;
                    
            FOUR: 
                if (in) 
                    next_state = FIVE;
                else 
                    next_state = IDLE;
                    
            FIVE: 
                if (in) 
                    next_state = SIX;
                else 
                    next_state = IDLE;
                    
            SIX: 
                if (in) 
                    next_state = SEVEN;
                else begin
                    disc = 1'b1;
                    next_state = IDLE;
                end
                
            SEVEN: 
                if (!in) begin
                    flag = 1'b1;
                    next_state = IDLE;
                end
                else begin
                    err = 1'b1;
                    next_state = SEVEN; // Stay in ERROR if continuous 1 detected
                end
                
            default: 
                next_state = IDLE;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

endmodule
