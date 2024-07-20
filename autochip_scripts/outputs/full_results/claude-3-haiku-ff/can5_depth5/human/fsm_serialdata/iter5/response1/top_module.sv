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
                if (in == 0) begin // Start bit detected
                    state <= START;
                    bit_count <= 1;
                    data_reg <= 0;
                end
                done <= 0;
            end
            START: begin
                bit_count <= bit_count + 1;
                if (bit_count == 9) begin // Start bit and 8 data bits
                    state <= DATA;
                    bit_count <= 0;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    out_byte <= data_reg;
                    done <= 1;
                    state <= IDLE;
                end
                else begin // Stop bit not detected
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin
                    state <= IDLE;
                end
                else begin
                    state <= WAIT_STOP;
                end
            end
        endcase
    end
end

endmodule
