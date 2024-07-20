module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    // Define states
    reg state;
    parameter A = 0, B = 1;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A; // Initialize to state A upon reset
        end else begin
            case (state)
                A: if (j) state <= B; // Transition to B if j is high
                B: if (k) state <= A; // Transition to A if k is high
            endcase
        end
    end
    
    // Output logic
    always @(state) begin
        case (state)
            A: out = 0;
            B: out = 1;
        endcase
    end
    
endmodule
