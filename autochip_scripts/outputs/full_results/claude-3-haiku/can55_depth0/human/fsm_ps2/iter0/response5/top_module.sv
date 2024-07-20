module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [1:0] byte_count;

parameter WAIT_FOR_START = 2'b00;
parameter RECEIVE_BYTE1 = 2'b01;
parameter RECEIVE_BYTE2 = 2'b10;
parameter RECEIVE_BYTE3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_START: begin
                if (in[3]) begin
                    state <= RECEIVE_BYTE1;
                    byte_count <= 1;
                end
                done <= 0;
            end
            RECEIVE_BYTE1: begin
                if (in[3]) begin
                    state <= RECEIVE_BYTE2;
                    byte_count <= 2;
                end
                else begin
                    state <= WAIT_FOR_START;
                    byte_count <= 0;
                end
                done <= 0;
            end
            RECEIVE_BYTE2: begin
                if (in[3]) begin
                    state <= RECEIVE_BYTE3;
                    byte_count <= 3;
                end
                else begin
                    state <= WAIT_FOR_START;
                    byte_count <= 0;
                end
                done <= 0;
            end
            RECEIVE_BYTE3: begin
                if (in[3]) begin
                    state <= RECEIVE_BYTE1;
                    byte_count <= 1;
                end
                else begin
                    state <= WAIT_FOR_START;
                    byte_count <= 0;
                end
                done <= 1;
            end
        endcase
    end
end

endmodule
