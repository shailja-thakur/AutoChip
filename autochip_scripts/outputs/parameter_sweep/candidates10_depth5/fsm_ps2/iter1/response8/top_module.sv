module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done_reg;
reg first_byte_received;  // Signal to indicate if the first byte has been received in the current message

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done_reg <= 0;
        first_byte_received <= 0;
    end else begin
        case (state)
            0: begin  // Idle state
                if (in[3] == 1) begin
                    state <= 1;  // Transition to first byte state
                    first_byte_received <= 1;
                end
            end
            1: begin  // First byte state
                state <= 2;  // Transition to second byte state
            end
            2: begin  // Second byte state
                state <= 3;  // Transition to third byte state
            end
            3: begin  // Third byte state
                state <= 0;  // Transition back to idle state
                done_reg <= 1;  // Signal the receipt of a complete message
            end
        endcase
    end
end

assign done = done_reg;

endmodule
