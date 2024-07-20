module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_START = 3'd0;
localparam STATE_DATA = 3'd1;
localparam STATE_STOP = 3'd2;
localparam STATE_WAIT = 3'd3;

reg [2:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_START;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            STATE_START: begin
                if (in == 0) begin // Start bit detected
                    state <= STATE_DATA;
                    bit_count <= 0;
                end
            end
            STATE_DATA: begin
                data_reg[bit_count] <= in; // Shift in data bit
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= STATE_STOP;
                end
            end
            STATE_STOP: begin
                if (in == 1) begin // Stop bit detected
                    out_byte <= data_reg;
                    done <= 1;
                    state <= STATE_START;
                end else begin
                    state <= STATE_WAIT;
                end
            end
            STATE_WAIT: begin
                if (in == 1) begin // Wait for stop bit
                    state <= STATE_START;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
