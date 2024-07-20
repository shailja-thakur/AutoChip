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
reg [3:0] timer;
reg [3:0] state;
parameter IDLE = 4'd0, DETECT = 4'd1, SHIFT = 4'd2, COUNTDOWN = 4'd3, WAIT = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT;
                end
                else begin
                    state <= IDLE;
                end
            end
            DETECT: begin
                if (data == 1'b1) begin
                    state <= DETECT;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT;
                end
                else begin
                    state <= IDLE;
                end
            end
            SHIFT: begin
                delay[3] <= data;
                state <= SHIFT;
                if (timer == 4'd3) begin
                    state <= COUNTDOWN;
                    timer <= 0;
                end
                else begin
                    timer <= timer + 1;
                end
            end
            COUNTDOWN: begin
                counting <= 1;
                if (count == delay) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT;
                end
                else begin
                    count <= count + 1;
                end
            end
            WAIT: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTDOWN) ? count : 4'bxxxx;

endmodule
