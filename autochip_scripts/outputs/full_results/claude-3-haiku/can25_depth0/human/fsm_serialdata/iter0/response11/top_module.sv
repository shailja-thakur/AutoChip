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
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 0) begin
                    state <= DATA_BITS;
                end
                else begin
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                shift_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'b1000) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    out_byte <= shift_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
