module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Initial state
    end else begin
        case (state)
            2'b00: begin // Waiting for first byte with in[3] = 1
                if (in[3] == 1) begin
                    state <= 2'b01; // Transition to state 01
                end
            end
            2'b01: begin // Waiting for second byte
                state <= 2'b10; // Transition to state 10
            end
            2'b10: begin // Waiting for third byte
                state <= 2'b00; // Transition to state 00
                done <= 1; // Signal receipt of a message
            end
        endcase
    end
end

endmodule
