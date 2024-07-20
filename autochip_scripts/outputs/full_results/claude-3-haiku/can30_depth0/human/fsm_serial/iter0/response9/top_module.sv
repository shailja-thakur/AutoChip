module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE     = 3'd0;
localparam START_BIT= 3'd1;
localparam DATA_BIT = 3'd2;
localparam STOP_BIT = 3'd3;
localparam WAIT_STOP= 3'd4;

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
                if (in == 1'b0) begin
                    state <= START_BIT;
                    bit_count <= 0;
                end
            end
            START_BIT: begin
                if (bit_count == 4'd1) begin
                    state <= DATA_BIT;
                    bit_count <= 0;
                end
                else
                    bit_count <= bit_count + 1;
            end
            DATA_BIT: begin
                data_reg[bit_count] <= in;
                if (bit_count == 4'd7) begin
                    state <= STOP_BIT;
                    bit_count <= 0;
                end
                else
                    bit_count <= bit_count + 1;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b1;
                end
                else begin
                    state <= WAIT_STOP;
                    bit_count <= 0;
                end
            end
            WAIT_STOP: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
                else
                    bit_count <= bit_count + 1;
            end
        endcase
    end
end

endmodule
