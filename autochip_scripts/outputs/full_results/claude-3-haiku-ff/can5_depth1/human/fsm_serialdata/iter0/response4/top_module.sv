module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 2'b00;
localparam START_BIT = 2'b01;
localparam DATA_BITS = 2'b10;
localparam STOP_BIT = 2'b11;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!in) begin
                    state <= START_BIT;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START_BIT: begin
                if (in) begin
                    state <= DATA_BITS;
                end
                else if (bit_count == 1) begin
                    state <= IDLE;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in;
                if (bit_count == 7) begin
                    state <= STOP_BIT;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP_BIT: begin
                if (in) begin
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else if (bit_count == 1) begin
                    state <= IDLE;
                    bit_count <= 0;
                    done <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
        endcase
    end
end

endmodule
