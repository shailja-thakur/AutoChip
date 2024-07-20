module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE = 0;
localparam STATE_START = 1;
localparam STATE_DATA = 2;
localparam STATE_STOP = 3;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= STATE_START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            STATE_START: begin
                if (bit_count == 0) begin
                    if (in == 0) begin // Start bit is valid
                        state <= STATE_DATA;
                        bit_count <= 1;
                    end
                    else begin // Start bit is not valid, wait for next start bit
                        state <= STATE_IDLE;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                    if (bit_count == 9) begin // 8 data bits and 1 stop bit
                        state <= STATE_STOP;
                        bit_count <= 0;
                    end
                end
            end
            STATE_DATA: begin
                data_reg[bit_count - 1] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 9) begin // 8 data bits and 1 stop bit
                    state <= STATE_STOP;
                    bit_count <= 0;
                end
            end
            STATE_STOP: begin
                if (in == 1) begin // Stop bit is valid
                    out_byte <= data_reg;
                    done <= 1;
                    state <= STATE_IDLE;
                end
                else begin // Stop bit is not valid, wait for next start bit
                    state <= STATE_IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
