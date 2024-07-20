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
reg [15:0] counter;

always @(posedge clk) begin
    if (reset) begin
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 16'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        if (!counting) begin
            // Look for 1101 pattern
            pattern <= {pattern[2:0], data};
            if (pattern == 4'b1101) begin
                // Shift in 4-bit delay
                delay <= {data, delay[3:1]};
                counter <= 16'd1000 * (delay + 1);
                counting <= 1'b1;
                done <= 1'b0;
            end
        end
        else begin
            // Countdown timer
            counter <= counter - 16'd1;
            if (counter == 16'd0) begin
                counting <= 1'b0;
                done <= 1'b1;
                while (!ack) begin
                    // Wait for ack
                end
            end
        end
    end
end

assign count = counting ? delay - (counter / 16'd1000) : 4'bxxxx;

endmodule
