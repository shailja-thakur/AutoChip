module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam IDLE = 2'b00;
localparam WAIT_START = 2'b01;
localparam RECEIVE_MESSAGE = 2'b10;

reg [1:0] state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= WAIT_START;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
            end
            WAIT_START: begin
                if (in[3]) begin
                    state <= RECEIVE_MESSAGE;
                    byte_count <= 2;
                    out_bytes[15:8] <= in;
                end else begin
                    state <= IDLE;
                    byte_count <= 0;
                end
            end
            RECEIVE_MESSAGE: begin
                out_bytes[7:0] <= in;
                if (byte_count == 3) begin
                    state <= IDLE;
                    byte_count <= 0;
                    done <= 1;
                end else begin
                    byte_count <= byte_count + 1;
                end
            end
        endcase
    end
end

endmodule
