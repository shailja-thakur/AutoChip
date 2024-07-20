module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter IDLE = 2'b00;
parameter START = 2'b01;
parameter DATA = 2'b10;
parameter STOP = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // Received 8 data bits and 1 stop bit
                    if (in == 1'b1) begin // Stop bit is correct
                        state <= IDLE;
                        done <= 1'b1;
                    end
                    else begin // Stop bit is incorrect
                        state <= IDLE;
                        done <= 1'b0;
                    end
                end
                else begin
                    bit_count <= bit_count + 1'b1;
                    if (bit_count < 4'd8) begin // Receiving data bits
                        data_reg[bit_count] <= in;
                    end
                    state <= DATA;
                end
            end
            DATA: begin
                state <= STOP;
            end
            STOP: begin
                state <= START;
            end
        endcase
    end
end

endmodule
