module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam [2:0] IDLE = 3'd0, START = 3'd1, DATA = 3'd2, STOP = 3'd3, ERROR = 3'd4;
reg [2:0] state, next_state;
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
        state <= next_state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state <= START;
                    bit_count <= 1; // Start from bit 1
                    data_reg <= 0;
                end
                else begin
                    next_state <= IDLE;
                end
                done <= 0;
            end
            START: begin
                if (bit_count == 4'd9) begin // Waited for 9 bits (start + 8 data)
                    next_state <= STOP;
                end
                else begin
                    next_state <= DATA;
                end
                bit_count <= bit_count + 1;
            end
            DATA: begin
                data_reg[bit_count-1] <= in; // Store the data bit
                if (bit_count == 4'd8) begin // Received all 8 data bits
                    next_state <= START;
                end
                else begin
                    next_state <= DATA;
                end
                bit_count <= bit_count + 1;
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    next_state <= IDLE;
                    done <= 1'b1;
                end
                else begin
                    next_state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
                    next_state <= IDLE;
                    done <= 0;
                end
                else begin
                    next_state <= ERROR;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
