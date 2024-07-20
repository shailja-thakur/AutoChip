module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    // Define the states
    typedef enum logic [1:0] {
        A,
        B,
        C
    } state_t;
    
    // Declare the state register and initialize it to state A
    reg state_t current_state; 
    initial current_state = A;
    
    // Declare the next state variable
    reg state_t next_state;
    
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= A; // Reset state is A
        end else begin
            current_state <= next_state; // Update the state based on next_state value
        end
    end
    
    always_comb begin
        case (current_state)
            A: begin
                if (s == 1) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            
            B: begin
                if (w == 1) begin
                    next_state = C;
                end else begin
                    next_state = B;
                end
            end
            
            C: begin
                if (w == 1) begin
                    next_state = C;
                end else begin
                    next_state = A;
                end
            end
        endcase
    end
    
    // Output z based on the current state
    always_ff @(posedge clk) begin
        if (current_state == C) begin
            z <= 1;
        end else begin
            z <= 0;
        end
    end
    
endmodule
