module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the state machine
localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

// Internal register to store the current state
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the state machine to the initial state
        state <= BYTE1;
        done <= 0;
    end
    else begin
        case (state)
            BYTE1: begin
                // Check the third bit of the input
                if (in[2]) begin
                    // Transition to BYTE2 state
                    state <= BYTE2;
                end
                else begin
                    // Remain in BYTE1 state
                    state <= BYTE1;
                end
            end
            BYTE2: begin
                // Transition to BYTE3 state
                state <= BYTE3;
            end
            BYTE3: begin
                // Transition to DONE state
                state <= DONE;
            end
            DONE: begin
                // Check the third bit of the input again
                if (in[2]) begin
                    // Transition back to BYTE2 state
                    state <= BYTE2;
                end
                else begin
                    // Transition back to BYTE1 state
                    state <= BYTE1;
                end
                // Assert the done signal
                done <= 1;
            end
            default: begin
                // Remain in the current state
                state <= state;
                done <= done;
            end
        endcase
    end
end

endmodule
