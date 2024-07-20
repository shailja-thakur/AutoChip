module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter DATA = 3'b010;
parameter STOP = 3'b011;
parameter ERROR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START: begin
                if (bit_count == 0 && in == 0) begin
                    bit_count <= bit_count + 1;
                    state <= DATA;
                end else if (in != 0) begin
                    state <= ERROR;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                data_reg[bit_count-1] <= in;
                if (bit_count == 8) begin
                    bit_count <= 0;
                    state <= STOP;
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1) begin
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
            default: begin
                state <= IDLE;
                bit_count <= 0;
                data_reg <= 0;
                done <= 0;
                out_byte <= 0;
            end
        endcase
    end
end

endmodule
