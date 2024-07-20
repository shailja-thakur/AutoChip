module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum logic [2:0] {
        S_IDLE = 3'b000,
        S_1    = 3'b001,
        S_11   = 3'b010,
        S_111  = 3'b011,
        S_1111 = 3'b100,
        S_11111= 3'b101,
        S_111110=3'b110,
        S_111111=3'b111
    } state_t;
    
    state_t state, next_state;
    
    // State Transition
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S_IDLE: begin
                if (in) 
                    next_state = S_1;
                else
                    next_state = S_IDLE;
            end
            
            S_1: begin
                if (in) 
                    next_state = S_11;
                else
                    next_state = S_IDLE;
            end
            
            S_11: begin
                if (in) 
                    next_state = S_111;
                else
                    next_state = S_IDLE;
            end
            
            S_111: begin
                if (in) 
                    next_state = S_1111;
                else
                    next_state = S_IDLE;
            end
            
            S_1111: begin
                if (in) 
                    next_state = S_11111;
                else
                    next_state = S_IDLE;
            end
            
            S_11111: begin
                if (in) 
                    next_state = S_111110;
                else
                    next_state = S_IDLE;
            end
            
            S_111110: begin
                if (in) begin
                    next_state = S_111111;
                    disc = 1;
                end
                else begin
                    next_state = S_IDLE;
                    flag = 1;
                end
            end
            
            S_111111: begin
                if (in) begin
                    next_state = S_111111; // Stay in error state
                    err = 1;
                end
                else
                    next_state = S_IDLE;
            end
            
            default: 
                next_state = S_IDLE;
        endcase
    end
endmodule
