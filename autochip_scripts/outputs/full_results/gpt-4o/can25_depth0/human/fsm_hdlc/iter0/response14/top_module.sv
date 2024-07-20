module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State Definitions
    typedef enum logic [2:0] {
        S_IDLE,
        S_0,
        S_01,
        S_011,
        S_0111,
        S_01111,
        S_011111,
        S_0111111,
        S_01111110
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        // Default values for outputs
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            S_IDLE: begin
                if (in) 
                    next_state = S_0;
            end
            
            S_0: begin
                if (in) 
                    next_state = S_01;
                else 
                    next_state = S_IDLE;
            end
            
            S_01: begin
                if (in) 
                    next_state = S_011;
                else 
                    next_state = S_IDLE;
            end
            
            S_011: begin
                if (in) 
                    next_state = S_0111;
                else 
                    next_state = S_IDLE;
            end
            
            S_0111: begin
                if (in) 
                    next_state = S_01111;
                else 
                    next_state = S_IDLE;
            end
            
            S_01111: begin
                if (in) 
                    next_state = S_011111;
                else 
                    next_state = S_IDLE;
            end
            
            S_011111: begin
                if (in) 
                    next_state = S_0111111;
                else 
                    next_state = S_IDLE;
            end
            
            S_0111111: begin
                if (in) begin
                    err = 1'b1;
                    next_state = S_0111111;
                end
                else 
                    next_state = S_01111110;
            end

            S_01111110: begin
                flag = 1'b1;
                next_state = S_IDLE;
            end

            default: begin
                next_state = S_IDLE;
            end
        endcase
        
        // Disc logic
        if (state == S_011111 && next_state == S_0111111)
            disc = 1'b1;
    end

endmodule
