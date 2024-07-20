module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [7:0] byte1, byte2, byte3;
reg reset_done;
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        reset_done <= 1'b0;
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        done <= 1'b0;
        out_bytes <= 0;
    end else begin
        case (state)
            2'b00: begin // Idle state
                if (in[3]) begin
                    state <= 2'b01;
                    byte1 <= in;
                end
            end
            2'b01: begin // First byte received
                byte2 <= in;
                state <= 2'b10;
            end
            2'b10: begin // Second byte received
                byte3 <= in;
                state <= 2'b00; // Return to idle state
                done <= 1'b1;
                out_bytes <= {byte1, byte2, byte3};
            end
            default: begin
                // Do nothing
            end
        endcase
    end
end

endmodule
