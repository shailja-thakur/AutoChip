module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 3'd0;
localparam START_BIT = 3'd1;
localparam DATA_BITS = 3'd2;
localparam STOP_BIT = 3'd3;
localparam WAIT_STOP = 3'd4;

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
                if (~in) begin // Start bit detected
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in) begin // Ensure start bit is valid
                    state <= DATA_BITS;
                end else begin
                    state <= WAIT_STOP; // Invalid start bit, wait for stop bit
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in; // Shift in data bits
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in) begin // Ensure stop bit is valid
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= WAIT_STOP; // Invalid stop bit, wait for stop bit
                end
            end
            WAIT_STOP: begin
                if (in) begin // Stop bit detected
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
