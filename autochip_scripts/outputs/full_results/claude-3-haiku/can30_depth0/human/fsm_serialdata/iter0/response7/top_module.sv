module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
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
                end else if (bit_count == 1 && in == 0) begin
                    bit_count <= bit_count + 1;
                    state <= DATA;
                end else if (bit_count > 1 && in != 0) begin
                    bit_count <= 0;
                    state <= IDLE;
                end
            end
            DATA: begin
                if (bit_count < 8) begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end else begin
                    state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                if (bit_count == 0 && in == 1) begin
                    bit_count <= bit_count + 1;
                    done <= 1;
                    out_byte <= data_reg;
                end else if (bit_count > 0 && in != 1) begin
                    bit_count <= 0;
                    done <= 0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
