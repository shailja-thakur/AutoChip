module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // Define state encoding
    typedef enum logic [2:0] {
        S0,  // Reset state / initial state
        S1,  // Saw one 0
        S2,  // Saw one 1
        S3,  // Saw two 1s
        S4,  // Saw three 1s
        S5,  // Saw four 1s
        S6,  // Saw five 1s
        S7,  // Saw six 1s
        S8   // Error state: saw seven or more 1s
    } state_t;
    
    state_t state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) 
            state <= S0;
        else 
            state <= next_state;
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        next_state = state; // Default to hold state
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S0: begin
                if (in) 
                    next_state = S2;
                else 
                    next_state = S1;
            end
            S1: begin
                if (in) 
                    next_state = S2;
                else 
                    next_state = S1;
            end
            S2: begin
                if (in) 
                    next_state = S3;
                else 
                    next_state = S1;
            end
            S3: begin
                if (in) 
                    next_state = S4;
                else 
                    next_state = S1;
            end
            S4: begin
                if (in) 
                    next_state = S5;
                else 
                    next_state = S1;
            end
            S5: begin
                if (in) 
                    next_state = S6;
                else 
                    next_state = S1;
            end
            S6: begin
                if (in) 
                    next_state = S7;
                else begin
                    next_state = S1;
                    disc = 1;
                end
            end
            S7: begin
                if (in) 
                    next_state = S8;
                else begin
                    next_state = S1;
                    flag = 1;
                end
            end
            S8: begin
                if (in) 
                    next_state = S8;
                else begin
                    next_state = S1;
                    err = 1;
                end
            end
            default: begin
                next_state = S0;
            end
        endcase
    end

endmodule
