module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam STATE_IDLE = 2'b00;
localparam STATE_START_BIT = 2'b01;
localparam STATE_DATA_BITS = 2'b10;
localparam STATE_STOP_BIT = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= STATE_START_BIT;
                    bit_count <= 0;
                end
            end
            STATE_START_BIT: begin
                if (in == 0) begin // Start bit confirmed
                    state <= STATE_DATA_BITS;
                end else begin // Start bit not detected
                    state <= STATE_IDLE;
                end
            end
            STATE_DATA_BITS: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= STATE_STOP_BIT;
                end
            end
            STATE_STOP_BIT: begin
                if (in == 1) begin // Stop bit detected
                    done <= 1;
                    state <= STATE_IDLE;
                end else begin // Stop bit not detected
                    state <= STATE_IDLE;
                end
            end
        endcase
    end
end

endmodule
