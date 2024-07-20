module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam S_IDLE = 2'b00;
localparam S_START_BIT = 2'b01;
localparam S_DATA_BITS = 2'b10;
localparam S_STOP_BIT = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] data_buffer;

always @(posedge clk) begin
    if (reset) begin
        state <= S_IDLE;
        bit_count <= 0;
        data_buffer <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            S_IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= S_START_BIT;
                    bit_count <= 0;
                    data_buffer <= 0;
                end
            end
            S_START_BIT: begin
                if (in == 0) begin // Start bit is valid
                    state <= S_DATA_BITS;
                end else begin // Start bit is invalid, go back to idle
                    state <= S_IDLE;
                end
            end
            S_DATA_BITS: begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= S_STOP_BIT;
                end
            end
            S_STOP_BIT: begin
                if (in == 1) begin // Stop bit is valid
                    out_byte <= data_buffer;
                    done <= 1;
                    state <= S_IDLE;
                end else begin // Stop bit is invalid, wait for valid stop bit
                    state <= S_STOP_BIT;
                end
                done <= 0;
            end
        endcase
    end
end

endmodule
