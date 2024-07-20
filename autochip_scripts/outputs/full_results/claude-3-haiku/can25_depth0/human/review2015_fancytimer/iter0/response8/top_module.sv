module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_IDLE = 3'b000;
localparam STATE_DETECT_START = 3'b001;
localparam STATE_CAPTURE_DELAY = 3'b010;
localparam STATE_COUNTING = 3'b011;
localparam STATE_WAIT_ACK = 3'b100;

reg [2:0] state;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (data == 1'b1) begin
                    state <= STATE_DETECT_START;
                end
            end
            STATE_DETECT_START: begin
                if (data == 1'b1) begin
                    state <= STATE_DETECT_START;
                end else if (data == 1'b0) begin
                    state <= STATE_CAPTURE_DELAY;
                    delay <= 0;
                end
            end
            STATE_CAPTURE_DELAY: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end else begin
                    counter <= 0;
                    state <= STATE_COUNTING;
                    counting <= 1;
                end
            end
            STATE_COUNTING: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end else begin
                    counter <= 0;
                    counting <= 0;
                    done <= 1;
                    state <= STATE_WAIT_ACK;
                end
            end
            STATE_WAIT_ACK: begin
                if (ack) begin
                    done <= 0;
                    state <= STATE_IDLE;
                end
            end
        endcase
    end
end

assign count = (state == STATE_COUNTING) ? delay - (counter / 1000) : 4'bxxxx;

endmodule
