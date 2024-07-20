module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    localparam IDLE = 2'b00;
    localparam START_BIT = 2'b01;
    localparam DATA_BITS = 2'b10;
    localparam STOP_BIT = 2'b11;

    reg [1:0] state;
    reg [3:0] bit_count;
    reg [7:0] data_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            data_reg <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 0) begin
                        state <= START_BIT;
                        bit_count <= 1;
                    end
                    done <= 0;
                end
                START_BIT: begin
                    if (bit_count == 1 && in == 0) begin
                        state <= DATA_BITS;
                        bit_count <= 1;
                    end else if (bit_count == 1 && in == 1) begin
                        state <= IDLE;
                        bit_count <= 0;
                    end else begin
                        bit_count <= bit_count + 1;
                    end
                end
                DATA_BITS: begin
                    data_reg[bit_count - 1] <= in;
                    if (bit_count == 8) begin
                        state <= STOP_BIT;
                        bit_count <= 1;
                    end else begin
                        bit_count <= bit_count + 1;
                    end
                end
                STOP_BIT: begin
                    if (in == 1) begin
                        done <= 1;
                        state <= IDLE;
                        bit_count <= 0;
                    end else if (in == 0) begin
                        state <= IDLE;
                        bit_count <= 0;
                    end
                end
            endcase
        end
    end

endmodule
