module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;
reg done_reg;
wire done;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // Reset to BYTE1 state
    else begin
        case (state)
            2'b00: begin // BYTE1 state
                if (in[2]) // Check third bit of input
                    state <= 2'b01; // Transition to BYTE2 state
                else
                    state <= 2'b00; // Remain in BYTE1 state
            end
            2'b01: begin // BYTE2 state
                state <= 2'b10; // Transition to BYTE3 state
            end
            2'b10: begin // BYTE3 state
                state <= 2'b11; // Transition to DONE state
            end
            2'b11: begin // DONE state
                if (in[2]) // Check third bit of input again
                    state <= 2'b01; // Transition to BYTE2 state
                else
                    state <= 2'b00; // Transition to BYTE1 state
            end
        endcase
    end
end

assign done = (state == 2'b11);

endmodule
