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

localparam WAIT_START = 2'b00;
localparam WAIT_DELAY = 2'b01;
localparam COUNTING   = 2'b10;
localparam DONE       = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Shift in the 1101 pattern
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= WAIT_DELAY;
                end
            end
            WAIT_DELAY: begin
                // Shift in the delay value
                delay <= {delay[2:0], data};
                if (delay[3:0] == 4'b1111) begin
                    state <= COUNTING;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNTING: begin
                // Count down the timer
                counter <= counter + 1;
                if (counter == (delay + 1) * 250) begin
                    counting <= 0;
                    if (delay == 0) begin
                        state <= DONE;
                        done <= 1;
                    end else begin
                        delay <= delay - 1;
                        counter <= 0;
                    end
                end
            end
            DONE: begin
                // Wait for acknowledgement
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay;

endmodule
