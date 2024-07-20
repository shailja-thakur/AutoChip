module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Parameter definition for states
    parameter A = 1'b0, B = 1'b1;

    // Register to store the current state
    reg state;
    reg next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: if (in)
                   next_state = A;
               else
                   next_state = B;
            B: if (in)
                   next_state = B;
               else
                   next_state = A;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic block to update state register on rising edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset state to B
        end else begin
            state <= next_state; // Update state with next state
        end
    end

    // Output assignment
    always @(state) begin
        if (state == B)
            out = 1'b1;  // Output high if the state is B
        else
            out = 1'b0;  // Output low if the state is A
    end

endmodule
