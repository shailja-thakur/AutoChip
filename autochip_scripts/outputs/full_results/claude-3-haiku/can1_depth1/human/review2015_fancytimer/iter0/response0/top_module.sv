module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] state;
reg [3:0] delay;
reg [11:0] counter;

localparam IDLE = 4'd0;
localparam DETECT_START = 4'd1;
localparam SHIFT_DELAY = 4'd2;
localparam COUNTING = 4'd3;
localparam WAIT_ACK = 4'd4;

assign count = delay - counter[11:2];

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        counter <= 0;
        delay <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    if (counter[1:0] == 2'b01) begin
                        state <= SHIFT_DELAY;
                        counter <= 0;
                    end
                    counter <= counter + 1;
                end else begin
                    state <= IDLE;
                    counter <= 0;
                end
            end
            SHIFT_DELAY: begin
                if (counter[3:0] == 4'b0100) begin
                    delay <= {data, delay[3:1]};
                    state <= COUNTING;
                    counter <= 0;
                    counting <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
            COUNTING: begin
                if (counter == {4'd0, delay, 2'b0}) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
