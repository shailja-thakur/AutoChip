module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

parameter IDLE = 2'b00;
parameter WAIT_BYTE1 = 2'b01;
parameter WAIT_BYTE2 = 2'b10;
parameter WAIT_BYTE3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    byte1 <= in;
                    state <= WAIT_BYTE2;
                end
            end
            WAIT_BYTE2: begin
                byte2 <= in;
                state <= WAIT_BYTE3;
            end
            WAIT_BYTE3: begin
                byte3 <= in;
                out_bytes <= {byte1, byte2, byte3};
                state <= IDLE;
                done <= 1;
            end
        endcase
    end
end

endmodule
