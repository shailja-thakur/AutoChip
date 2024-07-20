module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter IDLE = 3'd0;
parameter START = 3'd1;
parameter DATA = 3'd2;
parameter STOP = 3'd3;
parameter ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // 1 start bit + 8 data bits
                    if (in == 1'b1) begin // Stop bit detected
                        state <= STOP;
                    end else begin
                        state <= ERROR;
                    end
                end else begin
                    bit_count <= bit_count + 1;
                    data_reg[bit_count-1] <= in;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Valid stop bit
                    done <= 1'b1;
                    state <= IDLE;
                end else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
