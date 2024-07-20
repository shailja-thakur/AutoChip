module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    // Define the states
    typedef enum logic [2:0] {
        A,
        B,
        C,
        D,
        E,
        F
    } state_type;
    
    // Declare the current and next state signals
    logic [2:0] current_state;
    logic [2:0] next_state;
    
    // Determine the next state based on the current state and input w
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Define the state transitions
    always_comb begin
        case (current_state)
            A: begin
                if (w)
                    next_state = A;
                else
                    next_state = B;
            end
            
            B: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end
            
            C: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            
            D: begin
                if (w)
                    next_state = A;
                else
                    next_state = F;
            end
            
            E: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            
            F: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end            
        endcase
    end
    
    // Output z is high when the state machine is in state E or F 
    assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
    
endmodule
