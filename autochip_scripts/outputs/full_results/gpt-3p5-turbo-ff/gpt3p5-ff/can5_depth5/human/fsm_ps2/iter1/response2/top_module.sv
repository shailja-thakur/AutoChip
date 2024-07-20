module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done_next;
reg first_byte_received;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done_next <= 0;
        first_byte_received <= 0;
    end else begin
        case(state)
            0: begin  // Idle state, waiting for first byte of message
                if (in[3] == 1) begin
                    state <= 1;  // Received first byte, move to next state
                    first_byte_received <= 1;
                end
            end
            1: begin  // Received first byte, waiting for second byte
                state <= 2;  // Move to next state
            end
            2: begin  // Received second byte, waiting for third byte
                state <= 3;  // Move to next state
            end
            3: begin  // Received third byte, message complete
                state <= 0;  // Move back to idle state
                done_next <= 1;  // Signal message complete
            end
        endcase
    end
end

assign done = done_next;

endmodule
