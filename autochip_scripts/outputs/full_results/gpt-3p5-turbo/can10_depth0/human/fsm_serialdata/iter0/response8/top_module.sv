module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Idle state - wait for start bit
                if (in == 0) begin
                    state <= 1; // Transition to begin receiving data bits
                    out_byte <= 0; // Reset out_byte
                end
            end
            1: begin // Receiving data bits
                out_byte <= {out_byte[6:0], in}; // Shift in the data bit
                state <= state + 1; // Transition to next state
            end
            9: begin // Verify stop bit
                if (in == 1) begin
                    state <= 0; // Transition to idle state
                    done <= 1; // Assert done signal
                end else begin
                    state <= 8; // Stay in the same state until stop bit is found
                end
            end
            default: begin // Default case - should not occur
                state <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
