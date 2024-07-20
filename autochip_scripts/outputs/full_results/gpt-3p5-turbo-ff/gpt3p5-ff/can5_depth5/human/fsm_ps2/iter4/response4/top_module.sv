module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state;
reg done_next;
reg [7:0] prev_in; // Added line to store previous input byte
reg [2:0] byte_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done_next <= 0;
        byte_count <= 0;
    end else begin
        case(state)
            0: begin  // Idle state, waiting for first byte of message
                if (in[3] == 1 && prev_in[3] == 0) begin // First byte of message has in[3]=1 and previous byte had in[3]=0
                    state <= 1;  // Received first byte, move to next state
                    byte_count <= byte_count + 1;  // Increment byte count
                end
            end
            1: begin  // Received first byte, waiting for second byte
                state <= 2;  // Move to next state
                byte_count <= byte_count + 1;  // Increment byte count
            end
            2: begin  // Received second byte, waiting for third byte
                state <= 3;  // Move to next state
                byte_count <= byte_count + 1;  // Increment byte count
            end
            3: begin  // Received third byte, message complete
                state <= 0;  // Move back to idle state
                done_next <= 1;  // Signal message complete
                byte_count <= 0;  // Reset byte count
            end
        endcase
        prev_in <= in; // Store current input byte for comparison in the next cycle
    end
end

always @(posedge clk) begin
    if (byte_count == 2) begin
        done <= done_next;
        done_next <= 0;
    end else begin
        done <= 0;
    end
end

endmodule
