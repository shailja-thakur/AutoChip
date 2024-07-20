module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define the four states as enumerated values
    typedef enum logic [1:0] {A, B, C, D} state_type;
    
    // Define state register and next state variables
    reg state_type current_state;
    reg state_type next_state;
    
    // Define output register
    reg out_reg;
    
    // Define combinational logic for next state and output
    // based on the current state and input
    always_comb begin
        case (current_state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out_reg = 0;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out_reg = 0;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
                out_reg = 0;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out_reg = 1;
            end
            default: next_state = A;
        endcase
    end
    
    // Define sequential logic for state register and output
    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
        
        out <= out_reg;
    end

endmodule
