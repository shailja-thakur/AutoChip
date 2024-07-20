module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE    = 3'd0;
localparam STATE_START   = 3'd1;
localparam STATE_DATA    = 3'd2;
localparam STATE_STOP    = 3'd3;
localparam STATE_ERROR   = 3'd4;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (in == 0) begin // Start bit detected
                    state <= STATE_START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
                done <= 0;
            end
            STATE_START: begin
                if (bit_count == 0) begin
                    if (in == 0) begin // Valid start bit
                        state <= STATE_DATA;
                        bit_count <= 1;
                    end
                    else begin // Invalid start bit
                        state <= STATE_ERROR;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STATE_DATA: begin
                data_reg[bit_count - 1] <= in; // Shift in the data bit
                if (bit_count == 8) begin
                    state <= STATE_STOP;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STATE_STOP: begin
                if (in == 1) begin // Valid stop bit
                    state <= STATE_IDLE;
                    out_byte <= data_reg;
                    done <= 1;
                end
                else begin // Invalid stop bit
                    state <= STATE_ERROR;
                end
            end
            STATE_ERROR: begin
                if (in == 1) begin // Wait for the next start bit
                    state <= STATE_IDLE;
                end
            end
        endcase
    end
end

endmodule
