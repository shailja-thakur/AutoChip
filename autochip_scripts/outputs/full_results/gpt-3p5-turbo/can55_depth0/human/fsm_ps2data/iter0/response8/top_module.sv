module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
    end else begin
        case (state)
            2'b00: begin // Idle state
                if (in[3]) begin
                    state <= 2'b01;
                    byte1 <= in;
                end
            end
            2'b01: begin // Byte 1 received
                state <= 2'b10;
                byte2 <= in;
            end
            2'b10: begin // Byte 2 received
                state <= 2'b11;
                byte3 <= in;
            end
            2'b11: begin // Byte 3 received
                state <= 2'b00;
                out_bytes <= {byte1, byte2, byte3};
                done <= 1'b1;
            end
        endcase
    end
end

endmodule
