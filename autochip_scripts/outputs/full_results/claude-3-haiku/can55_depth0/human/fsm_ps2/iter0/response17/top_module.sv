module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
localparam STATE_WAIT = 0, STATE_BYTE1 = 1, STATE_BYTE2 = 2, STATE_BYTE3 = 3;

// Register to store the current state
reg [1:0] state;

// Register to store the received bytes
reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        done <= 0;
    end else begin
        case (state)
            STATE_WAIT: begin
                // Wait for the first byte with in[3] = 1
                if (in[3]) begin
                    byte1 <= in;
                    state <= STATE_BYTE1;
                end
            end
            STATE_BYTE1: begin
                // Receive the second byte
                byte2 <= in;
                state <= STATE_BYTE2;
            end
            STATE_BYTE2: begin
                // Receive the third byte
                byte3 <= in;
                state <= STATE_BYTE3;
            end
            STATE_BYTE3: begin
                // Signal the completion of the message
                done <= 1;
                state <= STATE_WAIT;
            end
        endcase
    end
end

endmodule
