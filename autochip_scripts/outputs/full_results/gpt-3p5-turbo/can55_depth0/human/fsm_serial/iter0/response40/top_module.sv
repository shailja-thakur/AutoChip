module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        case (state)
            3'b000: begin // Idle state
                if (in == 1'b0) begin
                    state <= 3'b001; // Start bit detected, move to the next state
                end
            end
            3'b001: begin // Receiving data bits
                state <= 3'b010; // Transition to the next state
            end
            3'b010: begin // Receiving data bits
                state <= 3'b011; // Transition to the next state
            end
            3'b011: begin // Receiving data bits
                state <= 3'b100; // Transition to the next state
            end
            3'b100: begin // Receiving data bits
                state <= 3'b101; // Transition to the next state
            end
            3'b101: begin // Receiving data bits
                state <= 3'b110; // Transition to the next state
            end
            3'b110: begin // Receiving data bits
                state <= 3'b111; // Transition to the next state
            end
            3'b111: begin // Receiving data bits
                if (in == 1'b1) begin
                    state <= 3'b000; // Stop bit detected, move back to idle state
                    done <= 1'b1; // Byte received successfully, set "done" signal high
                else
                    state <= 3'b110; // Stay in the same state until stop bit is detected
            end
            default: state <= 3'b000; // Default to idle state
        endcase
    end
end

endmodule
