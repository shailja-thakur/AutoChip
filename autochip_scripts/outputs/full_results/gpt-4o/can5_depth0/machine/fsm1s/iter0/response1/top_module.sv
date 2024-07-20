module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // Define states
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A; // default state
        endcase
    end

    // Sequential logic to update state on rising edge of clock
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B; // Reset state to B
        else 
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
