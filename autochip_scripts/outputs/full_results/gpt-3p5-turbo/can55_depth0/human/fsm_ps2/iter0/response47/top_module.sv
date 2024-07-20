module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;  // FSM state
reg [7:0] byte1;  // First byte of the message
reg [7:0] byte2;  // Second byte of the message
reg [7:0] byte3;  // Third byte of the message
reg done_reg;     // Register to hold the done signal

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;  // Go to initial state on reset
    else begin
        case (state)
            2'b00: begin  // Waiting for byte1 (in[3] = 1)
                if (in[3] == 1'b1) begin
                    byte1 <= in;
                    state <= 2'b01;  // Go to next state
                end
            end
            2'b01: begin  // Waiting for byte2
                byte2 <= in;
                state <= 2'b10;  // Go to next state
            end
            2'b10: begin  // Waiting for byte3
                byte3 <= in;
                state <= 2'b11;  // Go to next state
            end
            2'b11: begin  // Message received
                done_reg <= 1'b1;
                state <= 2'b00;  // Go back to initial state
            end
        endcase
    end
end

assign done = done_reg;

endmodule
