module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the FSM
localparam [1:0] 
    WAIT_FOR_START = 2'b00, 
    RECEIVE_BYTE1 = 2'b01,
    RECEIVE_BYTE2 = 2'b10,
    RECEIVE_BYTE3 = 2'b11;

// Internal state variable
reg [1:0] state;

// Counter to track the number of bytes received
reg [1:0] byte_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_START: begin
                // Wait for a byte with in[3] = 1
                if (in[3]) begin
                    state <= RECEIVE_BYTE1;
                    byte_count <= 1;
                end
                else begin
                    state <= WAIT_FOR_START;
                    byte_count <= 0;
                    done <= 0;
                end
            end
            RECEIVE_BYTE1: begin
                // Received the first byte of the message
                state <= RECEIVE_BYTE2;
                byte_count <= 2;
            end
            RECEIVE_BYTE2: begin
                // Received the second byte of the message
                state <= RECEIVE_BYTE3;
                byte_count <= 3;
            end
            RECEIVE_BYTE3: begin
                // Received the third byte of the message
                state <= WAIT_FOR_START;
                byte_count <= 0;
                done <= 1; // Signal that a complete message has been received
            end
        endcase
    end
end

endmodule
