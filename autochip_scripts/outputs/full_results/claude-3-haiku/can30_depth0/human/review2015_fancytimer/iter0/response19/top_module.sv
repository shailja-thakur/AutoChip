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

localparam [1:0] WAIT_PATTERN = 2'b00, WAIT_DELAY = 2'b01, COUNT = 2'b10, WAIT_ACK = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            WAIT_PATTERN: begin
                if (pattern == 4'b1101) begin
                    state <= WAIT_DELAY;
                    pattern <= 0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            WAIT_DELAY: begin
                delay <= {delay[2:0], data};
                if (delay[3]) begin
                    state <= COUNT;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNT: begin
                counter <= counter + 1;
                if (counter == delay + 1) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_PATTERN;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - counter + 1 : 0;

endmodule
