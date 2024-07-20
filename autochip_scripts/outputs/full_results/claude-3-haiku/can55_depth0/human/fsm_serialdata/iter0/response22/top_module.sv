module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE = 3'b000;
localparam STATE_START_BIT = 3'b001;
localparam STATE_READ_DATA = 3'b010;
localparam STATE_STOP_BIT = 3'b011;
localparam STATE_WAIT_STOP = 3'b100;

reg [2:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (~in) begin
                    state <= STATE_START_BIT;
                    bit_count <= 0;
                end
            end
            STATE_START_BIT: begin
                if (in) begin
                    state <= STATE_WAIT_STOP;
                end
                else begin
                    state <= STATE_READ_DATA;
                end
            end
            STATE_READ_DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 3'd7) begin
                    state <= STATE_STOP_BIT;
                end
            end
            STATE_STOP_BIT: begin
                if (in) begin
                    out_byte <= data_reg;
                    done <= 1;
                    state <= STATE_IDLE;
                end
                else begin
                    state <= STATE_WAIT_STOP;
                end
            end
            STATE_WAIT_STOP: begin
                if (in) begin
                    state <= STATE_IDLE;
                    done <= 0;
                end
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

endmodule
