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
        state <= 2'b00; // Initial state
        out_bytes <= 24'b0;
        done <= 0;
    end else begin
        case(state)
            2'b00: begin // Waiting for in[3] = 1
                if (in[3] == 1) begin
                    state <= 2'b01; // Byte 1 received
                    out_bytes[23:16] <= in;
                end
            end
            
            2'b01: begin // Byte 1 received, waiting for byte 2
                state <= 2'b10; // Byte 2 received
                out_bytes[15:8] <= in;
            end
            
            2'b10: begin // Byte 2 received, waiting for byte 3
                state <= 2'b11; // Byte 3 received
                out_bytes[7:0] <= in;
                done <= 1;
            end
            
            2'b11: begin // Byte 3 received, waiting for next message
                if (in[3] == 1) begin
                    state <= 2'b01; // Byte 1 received
                    out_bytes <= 24'b0;
                end else begin
                    state <= 2'b00; // Waiting for in[3] = 1
                end
                done <= 0;
            end
        endcase
    end
end

endmodule
