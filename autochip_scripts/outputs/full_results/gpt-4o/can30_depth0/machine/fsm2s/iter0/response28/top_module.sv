module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
  
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;
    
    // Sequential logic to handle state transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: if (j)
                   next_state = B;
               else 
                   next_state = A;
            B: if (k)
                   next_state = A;
               else 
                   next_state = B;
            default: next_state = A; // Default state
        endcase
    end
    
    // Output logic
    always @(state) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Default output
        endcase
    end

endmodule
