module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic block for next state generation
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A;
        endcase
    end
    
    // Sequential block for state updating
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset to initial state B
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end
    
endmodule
