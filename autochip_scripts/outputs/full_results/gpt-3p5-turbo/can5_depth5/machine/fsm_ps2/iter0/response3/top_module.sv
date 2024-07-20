module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State definition
    reg [1:0] state;

    // Register to store the previous value of the third bit of input
    reg prev_bit3;
  
  always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Reset to BYTE1 state
            prev_bit3 <= 1'b0; // Initialize previous bit3
        end
        else begin
            case (state)
                2'b00: begin // BYTE1 state
                    if (in[2] == 1'b1) // Check if third bit is 1
                        state <= 2'b01; // Transition to BYTE2 state
                    else
                        state <= 2'b00; // Remain in BYTE1 state
                end
                2'b01: begin // BYTE2 state
                    state <= 2'b10; // Transition to BYTE3 state
                end
                2'b10: begin // BYTE3 state
                    state <= 2'b11; // Transition to DONE state
                end
                2'b11: begin // DONE state
                    if (in[2] == 1'b0) // Check if third bit is 0
                        state <= 2'b00; // Transition to BYTE1 state
                    else
                        state <= 2'b01; // Transition to BYTE2 state
                end
                default: begin // Default case, should not occur
                    state <= 2'b00; // Reset to BYTE1 state
                    prev_bit3 <= 1'b0; // Initialize previous bit3
                end
            endcase
        end
    end

    // Output logic for the done signal
    assign done = (state == 2'b11);

endmodule
