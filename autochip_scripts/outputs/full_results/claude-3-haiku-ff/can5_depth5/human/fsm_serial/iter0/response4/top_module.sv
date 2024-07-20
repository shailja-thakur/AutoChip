module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

parameter IDLE = 2'b00;
parameter START = 2'b01;
parameter DATA = 2'b10;
parameter STOP = 2'b11;

reg [1:0] state;
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
                if (in == 1'b0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin
                    if (in == 1'b1) begin
                        state <= DATA;
                        bit_count <= 0;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                if (bit_count == 4'd8) begin
                    state <= STOP;
                    bit_count <= 0;
                    data_reg <= {in, data_reg[7:1]};
                end
                else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {in, data_reg[7:1]};
                end
            end
            STOP: begin
                if (bit_count == 4'd1) begin
                    if (in == 1'b1) begin
                        state <= IDLE;
                        done <= 1'b1;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
        endcase
    end
end

endmodule
