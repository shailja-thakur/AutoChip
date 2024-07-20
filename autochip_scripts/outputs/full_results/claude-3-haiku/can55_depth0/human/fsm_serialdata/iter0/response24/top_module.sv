module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] 
    IDLE = 3'b000,
    START_BIT = 3'b001,
    DATA_BITS = 3'b010,
    STOP_BIT = 3'b011;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_buffer;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_buffer <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                    data_buffer <= 0;
                end
            end
            START_BIT: begin
                if (in == 1'b0) begin // Valid start bit
                    state <= DATA_BITS;
                end else begin // Invalid start bit
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin // 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Valid stop bit
                    state <= IDLE;
                    out_byte <= data_buffer;
                    done <= 1'b1;
                end else begin // Invalid stop bit
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
