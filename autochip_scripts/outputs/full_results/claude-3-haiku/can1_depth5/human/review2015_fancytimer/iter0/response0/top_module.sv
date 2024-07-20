module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] count_reg;
reg [3:0] bit_count;
reg [3:0] state;

localparam IDLE = 0;
localparam START = 1;
localparam CAPTURE_DELAY = 2;
localparam COUNTING = 3;
localparam COMPLETE = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        bit_count <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && bit_count == 4'b0) begin
                    bit_count <= 1;
                end else if (data == 1'b0 && bit_count == 4'b1) begin
                    bit_count <= 2;
                end else if (data == 1'b1 && bit_count == 4'b2) begin
                    bit_count <= 3;
                end else if (data == 1'b0 && bit_count == 4'b3) begin
                    state <= START;
                    bit_count <= 0;
                end else begin
                    bit_count <= 0;
                end
            end
            START: begin
                delay <= 0;
                bit_count <= 0;
                state <= CAPTURE_DELAY;
            end
            CAPTURE_DELAY: begin
                if (bit_count < 4) begin
                    delay <= {data, delay[3:1]};
                    bit_count <= bit_count + 1;
                end else begin
                    state <= COUNTING;
                    count_reg <= delay;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (count_reg == 0) begin
                    state <= COMPLETE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    count_reg <= count_reg - 1;
                end
            end
            COMPLETE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? count_reg : 4'bxxxx;

endmodule
