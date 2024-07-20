module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [2:0] state;
reg [7:0] byte;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Idle state
                if (in == 0) begin // Detected start bit
                    state <= 1;
                    byte <= 0;
                end
            end
            1: begin // Receiving data bits
                byte <= {byte[6:0], in};
                if (byte == 8'b11111111) begin // All data bits received
                    state <= 2;
                end
            end
            2: begin // Waiting for stop bit
                if (in == 1) begin // Detected stop bit
                    state <= 3;
                end
            end
            3: begin // Check for correct stop bit
                if (in == 1) begin // Stop bit is correct
                    out_byte <= byte;
                    done <= 1;
                    state <= 0; // Go to idle state for next byte
                end else begin
                    state <= 2; // Wait for correct stop bit
                end
            end
        endcase
    end
end

endmodule
