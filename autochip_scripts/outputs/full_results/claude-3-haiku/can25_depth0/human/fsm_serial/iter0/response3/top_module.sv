module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'd0;
localparam START = 2'd1;
localparam DATA = 2'd2;
localparam STOP = 2'd3;

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
                if (bit_count == 4'd9) begin // Received 8 data bits and 1 stop bit
                    if (in == 1) begin // Stop bit is correct
                        state <= IDLE;
                        done <= 1;
                    end
                    else begin // Stop bit is incorrect
                        state <= STOP;
                        bit_count <= 0;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                    if (bit_count < 4'd8) begin // Shift in data bits
                        data_reg <= {data_reg[6:0], in};
                    end
                    state <= DATA;
                end
            end
            DATA: begin
                state <= START;
            end
            STOP: begin
                if (in == 1) begin // Stop bit found
                    state <= IDLE;
                    done <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
        endcase
    end
end

endmodule
