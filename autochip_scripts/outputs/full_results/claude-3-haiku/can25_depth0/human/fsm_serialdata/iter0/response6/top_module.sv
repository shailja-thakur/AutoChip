module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam STATE_IDLE = 3'b000;
localparam STATE_START = 3'b001;
localparam STATE_DATA = 3'b010;
localparam STATE_STOP = 3'b011;
localparam STATE_ERROR = 3'b100;

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
    end else begin
        case (state)
            STATE_IDLE: begin
                if (in == 0) begin
                    state <= STATE_START;
                    bit_count <= 0;
                end
            end
            STATE_START: begin
                if (bit_count == 0 && in == 0) begin
                    bit_count <= bit_count + 1;
                end else if (bit_count == 1 && in == 1) begin
                    state <= STATE_DATA;
                    bit_count <= 0;
                end else begin
                    state <= STATE_ERROR;
                end
            end
            STATE_DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    state <= STATE_STOP;
                    bit_count <= 0;
                end
            end
            STATE_STOP: begin
                if (in == 1) begin
                    out_byte <= data_reg;
                    done <= 1;
                    state <= STATE_IDLE;
                end else begin
                    state <= STATE_ERROR;
                end
            end
            STATE_ERROR: begin
                done <= 0;
                if (in == 1) begin
                    state <= STATE_IDLE;
                end
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

endmodule
