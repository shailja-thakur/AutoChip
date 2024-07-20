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
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin // 1 start bit + 8 data bits
                    if (in == 1'b1) begin // Stop bit detected
                        state <= STOP;
                    end
                    else begin // Stop bit missing
                        state <= IDLE;
                    end
                end
                else begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit valid
                    state <= IDLE;
                    done <= 1'b1;
                end
                else begin // Stop bit invalid
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
