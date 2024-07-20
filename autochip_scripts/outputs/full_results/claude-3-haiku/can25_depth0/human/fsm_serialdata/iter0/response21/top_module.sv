module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE = 2'b00;
localparam STATE_START = 2'b01;
localparam STATE_DATA = 2'b10;
localparam STATE_STOP = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;
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
                if (in == 0) begin
                    state <= STATE_START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            STATE_START: begin
                if (bit_count == 3'd0) begin
                    if (in == 0) begin
                        state <= STATE_DATA;
                    end else begin
                        state <= STATE_IDLE;
                    end
                end
                bit_count <= bit_count + 1;
            end
            STATE_DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 3'd7) begin
                    state <= STATE_STOP;
                    bit_count <= 0;
                end
            end
            STATE_STOP: begin
                if (bit_count == 3'd0) begin
                    if (in == 1) begin
                        out_byte <= data_reg;
                        done <= 1;
                    end else begin
                        state <= STATE_IDLE;
                    end
                end
                bit_count <= bit_count + 1;
                if (bit_count == 3'd1) begin
                    state <= STATE_IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
