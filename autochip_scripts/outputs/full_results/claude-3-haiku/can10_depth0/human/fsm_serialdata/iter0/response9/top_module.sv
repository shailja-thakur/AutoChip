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
parameter WAIT_STOP = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_reg <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                    shift_reg <= 0;
                end
            end
            START: begin
                if (bit_count == 0 && in == 0) begin
                    bit_count <= bit_count + 1;
                    state <= DATA;
                end else if (in != 0) begin
                    state <= IDLE;
                    bit_count <= 0;
                end
            end
            DATA: begin
                shift_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                if (in == 1) begin
                    done <= 1;
                    out_byte <= shift_reg;
                    state <= IDLE;
                    bit_count <= 0;
                end else begin
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin
                    state <= IDLE;
                    bit_count <= 0;
                end
            end
        endcase
    end
end

endmodule
