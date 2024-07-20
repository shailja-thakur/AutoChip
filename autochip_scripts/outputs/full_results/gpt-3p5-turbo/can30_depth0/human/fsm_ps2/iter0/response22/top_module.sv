module top_module (
    input clk,
    input reg [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        done <= 0;
    end else begin
        case (state)
            2'b00: begin // Waiting for first byte of message
                if (in[3] == 1) begin
                    state <= 2'b01;
                end
            end
            2'b01: begin // Received first byte, waiting for second byte
                state <= 2'b10;
            end
            2'b10: begin // Received second byte, waiting for third byte
                state <= 2'b11;
            end
            2'b11: begin // Received third byte, message complete
                state <= 2'b00;
                done <= 1;
            end
        endcase
    end
end

endmodule
