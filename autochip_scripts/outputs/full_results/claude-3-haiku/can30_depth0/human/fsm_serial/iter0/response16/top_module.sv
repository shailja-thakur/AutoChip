module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam DATA = 2'b10;
localparam STOP = 2'b11;

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
                if (in == 0) begin
                    state <= START;
                    bit_count <= 1;
                end
            end
            START: begin
                if (bit_count == 10) begin
                    if (in == 1) begin
                        state <= DATA;
                        bit_count <= 1;
                    end
                    else begin
                        state <= IDLE;
                        bit_count <= 0;
                    end
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                data_reg <= {in, data_reg[7:1]};
                if (bit_count == 9) begin
                    state <= STOP;
                    bit_count <= 1;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1) begin
                    state <= IDLE;
                    bit_count <= 0;
                    done <= 1;
                end
                else if (bit_count == 2) begin
                    state <= IDLE;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
        endcase
    end
end

endmodule
