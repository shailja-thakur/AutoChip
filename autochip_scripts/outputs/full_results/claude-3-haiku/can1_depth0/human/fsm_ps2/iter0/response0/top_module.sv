module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
parameter WAIT_FOR_HEADER = 0, RECEIVE_BYTE1 = 1, RECEIVE_BYTE2 = 2, RECEIVE_BYTE3 = 3;

// Internal state register
reg [1:0] state;

// Byte counter
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state machine and clear the done signal
        state <= WAIT_FOR_HEADER;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_HEADER: begin
                // Wait for the first byte with in[3] = 1
                if (in[3]) begin
                    state <= RECEIVE_BYTE1;
                    byte_count <= 1;
                end
            end
            RECEIVE_BYTE1: begin
                // Receive the first byte of the message
                byte_count <= byte_count + 1;
                state <= RECEIVE_BYTE2;
            end
            RECEIVE_BYTE2: begin
                // Receive the second byte of the message
                byte_count <= byte_count + 1;
                state <= RECEIVE_BYTE3;
            end
            RECEIVE_BYTE3: begin
                // Receive the third byte of the message
                byte_count <= byte_count + 1;
                // Signal that a complete message has been received
                done <= 1;
                // Reset the state machine to wait for the next message
                state <= WAIT_FOR_HEADER;
                byte_count <= 0;
            end
        endcase
    end
end

endmodule
