module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define states
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;  // Default state will be B
        endcase
    end

    // Sequential logic to update the state on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Output logic based on current state
    always @(state) begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b0;  // Default output value
        endcase
    end

endmodule
