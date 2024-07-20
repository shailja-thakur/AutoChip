module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;
reg done;

always @(posedge clk) begin
    if (reset)
        state <= 2'b00; // BYTE1 state
    else begin
        case (state)
            2'b00: begin // BYTE1 state
                if (in[2])
                    state <= 2'b01; // BYTE2 state
                else
                    state <= 2'b00; // Remain in BYTE1 state
            end
            2'b01: begin // BYTE2 state
                state <= 2'b10; // BYTE3 state
            end
            2'b10: begin // BYTE3 state
                state <= 2'b11; // DONE state
            end
            2'b11: begin // DONE state
                if (in[2])
                    state <= 2'b01; // Transition back to BYTE2 state
                else
                    state <= 2'b00; // Transition back to BYTE1 state
            end
            default: begin
                state <= 2'b00; // Default to BYTE1 state
            end
        endcase
    end
end

assign done = (state == 2'b11); // Done signal is asserted when in DONE state

endmodule
