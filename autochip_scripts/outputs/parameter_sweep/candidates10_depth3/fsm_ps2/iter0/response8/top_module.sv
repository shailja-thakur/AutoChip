module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1, byte2, byte3; // Store the three received bytes
reg [2:0] state; // State variable representing the FSM state

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 0; // Initialize state to 0 during reset
        byte1 <= 8'b0; // Initialize the byte variables to 0 during reset
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        done <= 0; // Set output 'done' to 0 during reset
    end else begin
        case (state)
            0: begin // Idle state, waiting for byte1 with in[3] = 1
                if (in[3] == 1) begin
                    byte1 <= in; // Store the received byte in byte1
                    state <= 1; // Move to state 1
                end
            end
            1: begin // Waiting for byte2
                byte2 <= in; // Store the received byte in byte2
                state <= 2; // Move to state 2
            end
            2: begin // Waiting for byte3
                byte3 <= in; // Store the received byte in byte3
                done <= 1; // Signal that a message has been received
                state <= 0; // Move back to state 0 to wait for the next message
            end
        endcase
    end
end

endmodule
