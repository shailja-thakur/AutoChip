module top_module (
    input clk,
    input in,
    input reset,
    output done
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
                    else
                        state <= 3; // Wait for correct stop bit
                end
            endcase
        end
    end

    // Output control
    assign done = (state == 0); // Output high when byte is received correctly

endmodule
