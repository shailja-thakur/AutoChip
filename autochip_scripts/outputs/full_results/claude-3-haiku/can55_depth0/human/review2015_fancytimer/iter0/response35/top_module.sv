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
reg [3:0] pattern;
reg [1:0] state;

parameter IDLE = 2'b00, DETECT = 2'b01, DELAY = 2'b10, FINISHED = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    state <= DETECT;
                    pattern <= 4'b0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT: begin
                if (counter == 4'b1111) begin
                    delay <= {data, pattern};
                    counter <= 4'b0;
                    state <= DELAY;
                    counting <= 1'b1;
                end else begin
                    counter <= counter + 1'b1;
                    pattern <= {pattern[2:0], data};
                end
            end
            DELAY: begin
                if (counter == delay) begin
                    counter <= 4'b0;
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= FINISHED;
                end else begin
                    counter <= counter + 1'b1;
                end
            end
            FINISHED: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule
