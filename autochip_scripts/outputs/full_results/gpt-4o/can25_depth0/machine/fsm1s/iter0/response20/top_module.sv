module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state;
    reg next_state;
    
    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A; // Default state
        endcase
    end
    
    // Sequential logic block to update state register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Assign output based on the state register
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
