module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (in == 1'b0) begin
                        state <= 3'b001; // Transition to start bit state
                    end
                end
                3'b001: begin // Start bit state
                    state <= 3'b010; // Transition to data bits state
                end
                3'b010: begin // Data bits state
                    state <= 3'b011; // Transition to stop bit state after 8 data bits
                end
                3'b011: begin // Stop bit state
                    if (in == 1'b1) begin
                        state <= 3'b000; // Transition to idle state after stop bit
                    end else begin
                        state <= 3'b100; // Transition to wait for stop bit state if next bit is not stop bit
                    end
                end
                3'b100: begin // Wait for stop bit state
                    if (in == 1'b1) begin
                        state <= 3'b011; // Transition to stop bit state if stop bit is found
                    end
                end
            endcase
        end
    end

    assign done = (state == 3'b000);

endmodule
