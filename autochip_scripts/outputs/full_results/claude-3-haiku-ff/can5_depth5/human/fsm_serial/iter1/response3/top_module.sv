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
                    bit_count <= 1; // Start counting bits from 1
                end
                done <= 0; // Reset done signal
            end
            START: begin
                if (bit_count == 4'd9) begin // End of start bit
                    state <= DATA;
                    bit_count <= 0; // Reset bit count for data bits
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                data_reg <= {data_reg[6:0], in}; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 4'd8) begin // All 8 data bits received
                    state <= STOP;
                    bit_count <= 0; // Reset bit count for stop bit
                end
            end
            STOP: begin
                if (bit_count == 4'd1 && in == 1'b1) begin // Stop bit received
                    state <= IDLE;
                    done <= 1'b1; // Set done signal
                end else if (in != 1'b1) begin // Stop bit violation
                    state <= ERROR;
                end
                bit_count <= bit_count + 1;
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait until line is idle
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
