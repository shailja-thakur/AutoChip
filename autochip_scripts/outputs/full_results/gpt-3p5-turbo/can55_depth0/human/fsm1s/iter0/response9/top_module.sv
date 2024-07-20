module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    wire next_state_out;
  
    // Define the states
    parameter B = 2'b00;
    parameter A = 2'b01;
  
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Reset state
        else
            state <= next_state_out;  // Next state logic
    end
  
    always @* begin
        case(state)
            B: begin
                out = 1;  // Output value for state B
                if (in)
                    next_state_out = B;  // Next state for state B and input = 1
                else
                    next_state_out = A;  // Next state for state B and input = 0
            end
            A: begin
                out = 0;  // Output value for state A
                if (in)
                    next_state_out = A;  // Next state for state A and input = 1
                else
                    next_state_out = B;  // Next state for state A and input = 0
            end
        endcase
    end
  
endmodule
