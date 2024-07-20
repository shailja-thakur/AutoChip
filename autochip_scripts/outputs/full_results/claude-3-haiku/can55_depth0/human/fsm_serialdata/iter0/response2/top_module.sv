module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE    = 2'b00;
localparam STATE_START   = 2'b01;
localparam STATE_DATA    = 2'b10;
localparam STATE_STOP    = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (in == 1'b0) begin // start bit detected
                    state <= STATE_START;
                    bit_count <= 0;
                    shift_reg <= 0;
                end
            end
            STATE_START: begin
                if (bit_count == 4'd9) begin // 9 bit-times have elapsed
                    if (in == 1'b1) begin // stop bit is correct
                        state <= STATE_DATA;
                        bit_count <= 0;
                    end
                    else begin // stop bit is incorrect, wait for next start bit
                        state <= STATE_IDLE;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STATE_DATA: begin
                if (bit_count == 4'd8) begin // all 8 data bits received
                    state <= STATE_STOP;
                    bit_count <= 0;
                    out_byte <= shift_reg;
                    done <= 1'b1;
                end
                else begin
                    shift_reg[6:0] <= shift_reg[7:1]; // shift in the new bit
                    shift_reg[7] <= in;
                    bit_count <= bit_count + 1;
                end
            end
            STATE_STOP: begin
                if (in == 1'b1) begin // stop bit is correct
                    state <= STATE_IDLE;
                    done <= 1'b0;
                end
                else begin // wait for stop bit
                    state <= STATE_IDLE;
                end
            end
        endcase
    end
end

endmodule
