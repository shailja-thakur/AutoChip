module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

parameter STATE_IDLE = 2'b00;
parameter STATE_START = 2'b01;
parameter STATE_DATA = 2'b10;
parameter STATE_STOP = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_buffer;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_buffer <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= STATE_START;
                    bit_count <= 0;
                    data_buffer <= 0;
                end
            end

            STATE_START: begin
                if (bit_count == 0) begin
                    if (in == 0) begin // Valid start bit
                        bit_count <= 1;
                    end
                    else begin // Invalid start bit, go back to idle
                        state <= STATE_IDLE;
                    end
                end
                else if (bit_count < 9) begin
                    data_buffer[bit_count-1] <= in;
                    bit_count <= bit_count + 1;
                end
                else begin // Received 8 data bits
                    if (in == 1) begin // Valid stop bit
                        state <= STATE_STOP;
                    end
                    else begin // Invalid stop bit, stay in this state until valid stop bit
                        bit_count <= 9;
                    end
                end
            end

            STATE_STOP: begin
                done <= 1;
                out_byte <= data_buffer;
                state <= STATE_IDLE;
            end

            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

endmodule
