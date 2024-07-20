module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the FSM
localparam STATE_WAIT_START = 0;
localparam STATE_RECEIVE_BYTE1 = 1;
localparam STATE_RECEIVE_BYTE2 = 2;
localparam STATE_RECEIVE_BYTE3 = 3;

// Internal registers
reg [1:0] state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT_START: begin
                // Wait for the first byte with in[3]=1
                if (in[3]) begin
                    state <= STATE_RECEIVE_BYTE1;
                    byte_count <= 1;
                end
                else begin
                    state <= STATE_WAIT_START;
                    byte_count <= 0;
                end
                done <= 0;
            end
            STATE_RECEIVE_BYTE1: begin
                // Received the first byte
                state <= STATE_RECEIVE_BYTE2;
                byte_count <= byte_count + 1;
                done <= 0;
            end
            STATE_RECEIVE_BYTE2: begin
                // Received the second byte
                state <= STATE_RECEIVE_BYTE3;
                byte_count <= byte_count + 1;
                done <= 0;
            end
            STATE_RECEIVE_BYTE3: begin
                // Received the third byte, signal done
                state <= STATE_WAIT_START;
                byte_count <= 0;
                done <= 1;
            end
            default: begin
                state <= STATE_WAIT_START;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
