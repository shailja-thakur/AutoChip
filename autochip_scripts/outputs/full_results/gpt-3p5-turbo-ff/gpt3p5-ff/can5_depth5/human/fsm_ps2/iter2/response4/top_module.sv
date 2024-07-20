module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg done_next;
reg [2:0] byte_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done_next <= 0;
        byte_count <= 0;
    end else begin
        case(state)
            0: begin  // Idle state, waiting for first byte of message
                if (in[3] == 1) begin
                    // Received first byte, move to next state
                    state <= 1;
                end
            end
            1: begin  // Received first byte, waiting for second byte
                state <= 2;  // Move to next state
            end
            2: begin  // Received second byte, waiting for third byte
                state <= 3;  // Move to next state
            end
            3: begin  // Received third byte, message complete
                // Move back to idle state
                state <= 0;
                // Signal message complete
                done_next <= 1;
            end
        endcase
        
        // Increment byte count only when in[3] is 1
        if (in[3] == 1) begin
            byte_count <= byte_count + 1;
        end
    end
end

always @(posedge clk) begin
    // Reset byte count when message is complete
    if (done_next == 1) begin
        byte_count <= 0;
    end
    
    // Signal done when byte_count reaches 3
    if (byte_count == 3) begin
        done <= 1;
    end else begin
        done <= 0;
    end
end

endmodule
