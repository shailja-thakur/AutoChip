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
reg [3:0] counter;
reg [3:0] state;

localparam IDLE = 0,
          DETECT_START = 1,
          READ_DELAY = 2,
          COUNTDOWN = 3,
          NOTIFY = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        counter <= 0;
        delay <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    if (counter == 0) begin
                        counter <= 1;
                    end
                    else if (counter == 1) begin
                        counter <= 2;
                    end
                    else if (counter == 2) begin
                        counter <= 3;
                    end
                    else if (counter == 3) begin
                        state <= READ_DELAY;
                        counter <= 0;
                    end
                end
                else begin
                    counter <= 0;
                end
            end
            READ_DELAY: begin
                delay[3] <= data;
                counter <= counter + 1;
                if (counter == 4) begin
                    counter <= 0;
                    state <= COUNTDOWN;
                    counting <= 1;
                end
            end
            COUNTDOWN: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000) begin
                    counter <= 0;
                    counting <= 0;
                    state <= NOTIFY;
                    done <= 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTDOWN) ? delay - (counter / 1000) : 0;

endmodule
