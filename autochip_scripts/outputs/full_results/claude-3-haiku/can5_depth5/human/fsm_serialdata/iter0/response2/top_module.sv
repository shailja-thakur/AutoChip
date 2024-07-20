module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] byte_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        byte_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 9) begin // 9 cycles have elapsed
                    if (in == 1) begin // Stop bit is correct
                        state <= STOP;
                        out_byte <= byte_reg;
                        done <= 1;
                    end
                    else begin // Stop bit is incorrect
                        state <= IDLE;
                        bit_count <= 0;
                        byte_reg <= 0;
                        done <= 0;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                    if (bit_count < 8) begin
                        byte_reg[bit_count] <= in;
                    end
                    state <= DATA;
                end
            end
            DATA: begin
                if (bit_count == 9) begin
                    state <= START;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                    if (bit_count < 8) begin
                        byte_reg[bit_count] <= in;
                    end
                end
            end
            STOP: begin
                done <= 0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
