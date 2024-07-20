module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

reg [3:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

localparam IDLE = 4'd0;
localparam START = 4'd1;
localparam DATA = 4'd2;
localparam STOP = 4'd3;
localparam WAIT_STOP = 4'd4;

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
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 3'd7) begin
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                if (bit_count == 3'd7) begin
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1) begin
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in == 1) begin
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
