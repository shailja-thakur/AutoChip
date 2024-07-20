module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);

reg [3:0] state; // Variable to store the current state of the finite-state machine

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 0; // Reset the state to 0 when reset is active high
    end else begin
        case (state)
            0: if (data) state <= 1; else state <= 0; // Transition to state 1 if data is high, otherwise remain in state 0
            1: if (data) state <= 2; else state <= 0; // Transition to state 2 if data is high, otherwise return to state 0
            2: if (data) state <= 3; else state <= 0; // Transition to state 3 if data is high, otherwise return to state 0
            3: if (data) begin
                    state <= 4; // Transition to state 4 if data is high, indicating the sequence 1101 is found
                    start_shifting <= 1; // Set start_shifting to 1 when the sequence is found
                end else begin
                    state <= 0; // Return to state 0 if data is low, indicating the sequence is not complete
                    start_shifting <= 0; // Set start_shifting to 0 when the sequence is not found
                end
            4: begin
                    state <= 4; // Remain in state 4 once the sequence is found
                    start_shifting <= 1; // Set start_shifting to 1 when the sequence is found
                end
        endcase
    end
end

endmodule
