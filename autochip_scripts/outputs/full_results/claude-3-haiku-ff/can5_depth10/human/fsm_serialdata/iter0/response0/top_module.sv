module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00;
localparam WAIT_START = 2'b01;
localparam RECEIVE_DATA = 2'b10;
localparam WAIT_STOP = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] byte_buffer;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        byte_buffer <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= WAIT_START;
                    bit_count <= 0;
                    byte_buffer <= 0;
                end
            end
            WAIT_START: begin
                if (in == 1) begin // Start bit confirmed
                    state <= RECEIVE_DATA;
                end
            end
            RECEIVE_DATA: begin
                byte_buffer[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin // Received all 8 data bits
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin // Stop bit detected
                    out_byte <= byte_buffer;
                    done <= 1;
                    state <= IDLE;
                end else begin // Stop bit not detected, wait for it
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
