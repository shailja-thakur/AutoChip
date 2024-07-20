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
parameter IDLE = 0, DETECT = 1, LOAD_DELAY = 2, COUNT = 3, NOTIFY = 4;

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
                if (data == 1'b1 && counter == 4'b1101) begin
                    state <= LOAD_DELAY;
                    counter <= 0;
                end else begin
                    if (data == 1'b1) begin
                        counter[3:0] <= {counter[2:0], data};
                    end else begin
                        counter <= 0;
                    end
                end
            end
            LOAD_DELAY: begin
                if (counter == 4'b1111) begin
                    delay <= counter;
                    counter <= 0;
                    state <= COUNT;
                    counting <= 1;
                end else begin
                    counter[3:0] <= {counter[2:0], data};
                end
            end
            COUNT: begin
                if (counter == delay) begin
                    counting <= 0;
                    state <= NOTIFY;
                    done <= 1;
                end else begin
                    counter <= counter + 1;
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

assign count = counting ? delay - counter : 4'bxxxx;

endmodule
