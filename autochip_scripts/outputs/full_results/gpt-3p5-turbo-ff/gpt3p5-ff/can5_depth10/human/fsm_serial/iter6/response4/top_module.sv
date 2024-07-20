module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    reg [3:0] state;           // FSM state register
    reg [7:0] data;            // Received data register
    reg [2:0] bit_counter;     // Counter for tracking received bits

    // Start bit detection and data reception
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            bit_counter <= 0;
            data <= 0;
        end else begin
            case(state)
                0: begin                 // Idle state, wait for start bit
                    if (in == 1'b0)
                        state <= 1;
                end
                1: begin                 // Receive data bits
                    if (bit_counter == 7)
                        state <= 2;
                    bit_counter <= bit_counter + 1;
                    data <= {data[6:0], in};
                end
                2: begin                 // Verify stop bit
                    if (in == 1 && data == 8'b01111110)   // Check for correct stop bit
                        state <= 0;             // Go back to idle state
                    else
                        state <= 3;             // Wait for correct stop bit
                    bit_counter <= 0;           // Reset bit counter
                end
                3: begin                 // Verify stop bit
                    if (in == 1 && data == 8'b01111110)   // Check for correct stop bit
                        state <= 0;             // Go back to idle state
                    else if (in == 1'b0)     // Invalid stop bit detected, reset to idle state
                        state <= 0;
                end
            endcase
        end
    end

    // Output control
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else if (state == 0 && in == 1'b1)
            done <= 1;
        else
            done <= 0;
    end

endmodule
