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
reg [19:0] counter;

always @(posedge clk) begin
    if (reset) begin
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 20'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        // Shift in new bit
        pattern <= {pattern[2:0], data};

        // Check for start pattern 1101
        if (pattern == 4'b1101) begin
            // Shift in delay
            delay <= {data, data, data, data};
            counting <= 1'b1;
            counter <= 20'b0;
        end

        // Count down
        if (counting) begin
            counter <= counter + 1;
            if (counter == (delay + 1) * 1000) begin
                counting <= 1'b0;
                done <= 1'b1;
            end
        end

        // Wait for acknowledge
        if (done && ack) begin
            done <= 1'b0;
        end
    end
end

assign count = counting ? delay - (counter / 1000) : 4'bxxxx;

endmodule
