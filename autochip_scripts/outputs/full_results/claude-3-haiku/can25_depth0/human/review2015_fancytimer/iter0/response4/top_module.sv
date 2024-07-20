module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 3'd0, DETECT_START = 3'd1, LOAD_DELAY = 3'd2, COUNTDOWN = 3'd3, NOTIFY = 3'd4;
reg [2:0] state;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        delay <= 4'b0;
        counter <= 10'b0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    if ({data, data, data, data} == 4'b1101) begin
                        state <= DETECT_START;
                    end
                end
            end
            DETECT_START: begin
                if ({data, data, data, data} != 4'b1101) begin
                    state <= LOAD_DELAY;
                    delay <= {data, data, data, data};
                    counter <= 10'b0;
                end
            end
            LOAD_DELAY: begin
                counting <= 1'b1;
                state <= COUNTDOWN;
            end
            COUNTDOWN: begin
                counter <= counter + 1;
                if (counter == ((delay + 1) * 10'd1000 - 1)) begin
                    state <= NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

assign count = (state == COUNTDOWN) ? delay - (counter / 1000) : 4'b0;

endmodule
