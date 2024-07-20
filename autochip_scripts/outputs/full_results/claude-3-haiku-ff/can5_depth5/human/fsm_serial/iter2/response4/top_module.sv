module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 3'd0;
localparam START = 3'd1;
localparam DATA = 3'd2;
localparam STOP = 3'd3;
localparam ERROR = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 1; // Start counting from 1 instead of 0
                end
                done <= 0; // Reset done signal at the beginning of each byte
            end
            START: begin
                bit_count <= bit_count + 1;
                if (bit_count == 4'd10) begin // 10 bits (1 start bit, 8 data bits, 1 stop bit)
                    state <= DATA;
                    bit_count <= 0;
                end
            end
            DATA: begin
                data_reg <= {data_reg[6:0], in};
                bit_count <= bit_count + 1;
                if (bit_count == 4'd8) begin
                    state <= STOP;
                end
            end
            STOP: begin
                bit_count <= bit_count + 1;
                if (bit_count == 4'd10) begin
                    if (in == 1'b1) begin
                        state <= IDLE;
                        done <= 1'b1; // Set done signal when stop bit is valid
                    end else begin
                        state <= ERROR;
                    end
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
