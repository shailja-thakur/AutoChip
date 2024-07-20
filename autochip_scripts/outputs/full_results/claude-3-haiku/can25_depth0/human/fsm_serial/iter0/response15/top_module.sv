module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter ERROR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

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
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (in == 0) begin
                    state <= DATA_BITS;
                end
                else begin
                    state <= ERROR;
                end
            end
            DATA_BITS: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd8) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    state <= IDLE;
                    done <= 1;
                end
                else begin
                    state <= ERROR;
                end
            end
            ERROR: begin
                state <= IDLE;
                done <= 0;
            end
        endcase
    end
end

endmodule
