module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE = 0, STATE_START = 1, STATE_DATA = 2, STATE_STOP = 3;
reg [1:0] state, next_state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            STATE_IDLE: begin
                if (in == 0) begin // Start bit detected
                    next_state <= STATE_START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
                else begin
                    next_state <= STATE_IDLE;
                end
            end
            STATE_START: begin
                if (in == 0) begin // Wait for start bit to end
                    next_state <= STATE_DATA;
                end
                else begin
                    next_state <= STATE_IDLE; // Start bit not detected, wait for next byte
                end
            end
            STATE_DATA: begin
                data_reg[bit_count] <= in; // Shift in data bits
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin // All 8 data bits received
                    next_state <= STATE_STOP;
                end
                else begin
                    next_state <= STATE_DATA;
                end
            end
            STATE_STOP: begin
                if (in == 1) begin // Stop bit detected
                    out_byte <= data_reg;
                    done <= 1;
                    next_state <= STATE_IDLE;
                end
                else begin
                    next_state <= STATE_IDLE; // Stop bit not detected, wait for next byte
                end
            end
        endcase
    end
end

endmodule
