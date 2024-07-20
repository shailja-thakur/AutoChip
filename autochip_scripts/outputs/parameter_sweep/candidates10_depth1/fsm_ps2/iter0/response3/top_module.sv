module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] buffer [0:2];  // Buffer to store the received bytes
reg [7:0] temp;  // Temporary variable to store the current input byte
reg [1:0] state;  // FSM state variable

// Initialize the states and buffer
initial begin
    state <= 2'b00;
    buffer[0] <= 8'b0;
    buffer[1] <= 8'b0;
    buffer[2] <= 8'b0;
end

// Sequential logic
always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        buffer[0] <= 8'b0;
        buffer[1] <= 8'b0;
        buffer[2] <= 8'b0;
    end else begin
        case (state)
            // Wait for first byte with in[3]=1
            2'b00: begin
                buffer[0] <= in;
                if (in[3]) begin
                    state <= 2'b01;  // Transition to state 01
                end
            end
            // Receive the second byte
            2'b01: begin
                buffer[1] <= in;
                state <= 2'b10;  // Transition to state 10
            end
            // Receive the third byte and signal done
            2'b10: begin
                buffer[2] <= in;
                state <= 2'b11;  // Transition to state 11
                done <= 1;  // Signal done
            end
            // Clear the done signal in the next cycle
            2'b11: begin
                state <= 2'b00;  // Transition back to state 00
                done <= 0;  // Clear done
            end
        endcase
    end
end

endmodule
