module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
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
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin // Received 8 data bits
                    state <= DATA;
                end
            end
            DATA: begin
                data_reg[bit_count - 1] <= in; // Shift in data bits
                bit_count <= bit_count + 1;
                if (bit_count == 9) begin // Received all 8 data bits
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    done <= 1;
                    state <= IDLE;
                end
                else begin // Stop bit not detected, wait for next start bit
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
