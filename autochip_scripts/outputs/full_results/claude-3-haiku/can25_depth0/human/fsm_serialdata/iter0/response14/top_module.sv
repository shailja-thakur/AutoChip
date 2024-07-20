module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] temp_byte;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        temp_byte <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                    temp_byte <= 0;
                end
            end
            START: begin
                if (bit_count == 0) begin
                    if (in == 0) begin // Valid start bit
                        state <= DATA;
                        bit_count <= 1;
                    end
                    else begin // Invalid start bit, back to IDLE
                        state <= IDLE;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                temp_byte[bit_count - 1] <= in;
                if (bit_count == 8) begin
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1) begin // Valid stop bit
                    out_byte <= temp_byte;
                    done <= 1;
                    state <= IDLE;
                end
                else begin // Invalid stop bit, wait for next stop bit
                    state <= STOP;
                end
            end
        endcase
    end
end

endmodule
