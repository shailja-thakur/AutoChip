module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] bit_count;
reg [2:0] state;

localparam IDLE = 3'd0;
localparam START = 3'd1;
localparam CAPTURE_DELAY = 3'd2;
localparam COUNTING = 3'd3;
localparam COMPLETE = 3'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        bit_count <= 4'b0;
        count <= 4'b0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && bit_count == 4'b0) begin
                    bit_count <= 4'b1;
                end else if (data == 1'b0 && bit_count == 4'b1) begin
                    bit_count <= 4'b10;
                end else if (data == 1'b1 && bit_count == 4'b10) begin
                    bit_count <= 4'b11;
                end else if (data == 1'b0 && bit_count == 4'b11) begin
                    state <= START;
                    bit_count <= 4'b0;
                end else begin
                    bit_count <= 4'b0;
                end
            end
            START: begin
                delay <= 4'b0;
                bit_count <= 4'b0;
                state <= CAPTURE_DELAY;
            end
            CAPTURE_DELAY: begin
                if (bit_count < 4) begin
                    delay <= {data, delay[3:1]};
                    bit_count <= bit_count + 4'b1;
                end else begin
                    state <= COUNTING;
                    count <= delay + 4'b1;
                    counting <= 1'b1;
                end
            end
            COUNTING: begin
                if (count == 4'b0001) begin
                    state <= COMPLETE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end else begin
                    count <= count - 4'b1;
                end
            end
            COMPLETE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
