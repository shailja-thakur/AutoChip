module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Finite state machine states
localparam STATE_WAIT_START = 0;
localparam STATE_RECEIVE_BYTE1 = 1;
localparam STATE_RECEIVE_BYTE2 = 2;
localparam STATE_RECEIVE_BYTE3 = 3;

reg [1:0] state;

// Register to store the received bytes
reg [7:0] byte1, byte2, byte3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        done <= 0;
        out_bytes <= 0;
    end else begin
        case (state)
            STATE_WAIT_START: begin
                // Wait for the start of a message
                if (in[3]) begin
                    state <= STATE_RECEIVE_BYTE1;
                    byte1 <= in;
                end else begin
                    state <= STATE_WAIT_START;
                end
                done <= 0;
            end
            STATE_RECEIVE_BYTE1: begin
                // Receive the first byte of the message
                byte1 <= in;
                state <= STATE_RECEIVE_BYTE2;
                done <= 0;
            end
            STATE_RECEIVE_BYTE2: begin
                // Receive the second byte of the message
                byte2 <= in;
                state <= STATE_RECEIVE_BYTE3;
                done <= 0;
            end
            STATE_RECEIVE_BYTE3: begin
                // Receive the third byte of the message
                byte3 <= in;
                state <= STATE_WAIT_START;
                // Assemble the output bytes and assert the done signal
                out_bytes <= {byte1, byte2, byte3};
                done <= 1;
            end
        endcase
    end
end

endmodule
