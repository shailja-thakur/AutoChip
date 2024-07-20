module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    // Define the states
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter S10 = 3;
    parameter S11 = 4;
    parameter S20 = 5;
    parameter S21 = 6;
    parameter S22 = 7;
    
    // Define the current state and next state variables
    reg [2:0] state;
    reg [2:0] next_state;
    
    // Assign the initial state based on reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Assign the next state based on the current state and inputs
    always @(state, s, w) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = next_state; // No state transition
            end
            
            B: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            
            C: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            
            S10: begin
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
            end
            
            S11: begin
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
            end
            
            S20: begin
                next_state = B;
            end
            
            S21: begin
                if (w)
                    next_state = C;
                else
                    next_state = B;
            end
            
            S22: begin
                if (w)
                    next_state = B;
                else
                    next_state = C;
            end
        endcase
    end
    
    // Update the output based on the current state
    always @(state) begin
        case (state)
            A: begin
                z = 0;
            end
            
            B: begin
                z = 1;
            end
            
            C: begin
                z = 0;
            end
            
            S10: begin
                z = 0;
            end
            
            S11: begin
                z = 0;
            end
            
            S20: begin
                z = 1;
            end
            
            S21: begin
                z = 0;
            end
            
            S22: begin
                z = 0;
            end
        endcase
    end
    
endmodule
