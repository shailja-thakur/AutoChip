module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

localparam IDLE = 3'b000;
localparam START_BIT = 3'b001;
localparam DATA_BITS = 3'b010;
localparam STOP_BIT = 3'b011;
localparam WAIT_STOP = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START_BIT;
                    bit_count <= 1;
                end
            end
            START_BIT: begin
                if (in == 0) begin
                    state <= DATA_BITS;
                    bit_count <= 1;
                end
                else begin
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count-1] <= in;
                if (bit_count == 8) begin
                    state <= STOP_BIT;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1;
                end
                else begin
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
