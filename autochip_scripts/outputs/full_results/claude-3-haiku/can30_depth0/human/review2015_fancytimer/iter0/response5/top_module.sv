module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] pattern;
reg [3:0] delay;
reg [15:0] timer;

always @(posedge clk) begin
    if (reset) begin
        pattern <= 4'b0000;
        delay <= 4'b0000;
        timer <= 16'b0000000000000000;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        // Shift in the pattern
        pattern <= {pattern[2:0], data};

        // If the pattern is 1101, start the timer
        if (pattern == 4'b1101) begin
            // Shift in the delay
            delay <= {data, delay[3:1]};
            timer <= (delay + 16'b1) * 16'b1000000000000000;
            counting <= 1'b1;
        end

        // Decrement the timer
        if (counting) begin
            if (timer > 16'b0) begin
                timer <= timer - 16'b1;
            end
            else begin
                counting <= 1'b0;
                done <= 1'b1;
            end
        end

        // Wait for user to acknowledge
        if (done && ack) begin
            done <= 1'b0;
        end
    end
end

assign count = delay - (timer / 16'b1000000000000000);

endmodule
