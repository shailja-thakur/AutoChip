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
    
    // Combinational logic: Determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // Default to initial state
        endcase
    end
    
    // Sequential logic: Update state on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Initial state
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    assign out = (state == B);
    
endmodule
