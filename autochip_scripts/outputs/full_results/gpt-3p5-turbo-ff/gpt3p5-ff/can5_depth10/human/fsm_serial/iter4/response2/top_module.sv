module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    reg [3:0] state; // FSM state register
    reg [7:0] data; // Received data register

    // Start bit detection
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 0;
        else begin
            case(state)
                0: begin // Idle state, wait for start bit
                    if (in == 1'b0)
                        state <= 1;
                end
                1: begin // Receive data bits
                    state <= 2;
                    data <= 0;
                end
                2: begin // Receive data bits
                    data <= {data[6:0], in};
                    state <= 3;
                end
                3: begin // Verify stop bit
                    if (in == 1 && data == 8'b01111110) // Check for correct stop bit
                        state <= 0; // Go back to idle state
                    else if (in == 1) // If stop bit is incorrect, wait for next stop bit
                        state <= 3;
                end
            endcase
        end
    end

    // Output control
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else if (state == 0 && in == 1'b1) // Reset done signal if input line is idle
            done <= 0;
        else if (state == 3 && in == 1'b0) // Set done signal when stop bit is received correctly
            done <= 1;
        else
            done <= 0;
    end

endmodule
