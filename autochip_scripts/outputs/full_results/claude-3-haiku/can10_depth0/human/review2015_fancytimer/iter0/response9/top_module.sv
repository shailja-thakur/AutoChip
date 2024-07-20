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

localparam [3:0] IDLE = 0,
                 DETECT_PATTERN = 1,
                 SHIFT_DELAY = 2,
                 COUNT_DOWN = 3,
                 NOTIFY_USER = 4;

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
                    state <= DETECT_PATTERN;
                end
                else begin
                    state <= IDLE;
                end
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_DELAY;
                end
                else begin
                    state <= IDLE;
                end
            end
            SHIFT_DELAY: begin
                delay <= {data, delay[3:1]};
                if (counter == 4'b0011) begin
                    state <= COUNT_DOWN;
                    counter <= 0;
                    counting <= 1;
                end
                else begin
                    counter <= counter + 1;
                    state <= SHIFT_DELAY;
                end
            end
            COUNT_DOWN: begin
                if (counter == delay) begin
                    state <= NOTIFY_USER;
                    counter <= 0;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    counter <= counter + 1;
                end
            end
            NOTIFY_USER: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 0;
                end
                else begin
                    state <= NOTIFY_USER;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule
