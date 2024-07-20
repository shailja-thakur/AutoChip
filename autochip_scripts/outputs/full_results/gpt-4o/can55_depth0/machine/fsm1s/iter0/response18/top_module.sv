module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // default state should be B to handle undefined states
        endcase
    end

    // Sequential logic to update state on rising edge of clock
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        out = (state == B);
    end

endmodule
