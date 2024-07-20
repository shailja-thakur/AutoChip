module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00; // Initialize state to BYTE1
        out_bytes <= 0; // Reset out_bytes to 0
        done <= 0; // Reset done to 0
    end else begin
        case (state)
            2'b00: begin // BYTE1 state
                if (in[2] == 1) begin
                    state <= 2'b01; // Transition to BYTE2 state
                end else begin
                    state <= 2'b00; // Stay in BYTE1 state
                end
                out_bytes <= {in, out_bytes[23:8]}; // Shift in the input into out_bytes
            end
            2'b01: begin // BYTE2 state
                state <= 2'b10; // Transition to BYTE3 state
                out_bytes <= {in, out_bytes[23:8]}; // Shift in the input into out_bytes
            end
            2'b10: begin // BYTE3 state
                if (in[2] == 1) begin
                    state <= 2'b11; // Transition to DONE state
                end else begin
                    state <= 2'b00; // Transition back to BYTE1 state
                end
                out_bytes <= {in, out_bytes[23:8]}; // Shift in the input into out_bytes
            end
            2'b11: begin // DONE state
                state <= 2'b00; // Transition back to BYTE1 state
                done <= 1; // Set done to 1
                out_bytes <= {in, out_bytes[23:8]}; // Shift in the input into out_bytes
            end
        endcase
    end
end

endmodule
