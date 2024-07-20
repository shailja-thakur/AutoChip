module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] pattern;
reg [3:0] delay;
reg [19:0] counter;
reg [19:0] delay_cycles;

always @(posedge clk) begin
    if (reset) begin
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 20'b0;
        delay_cycles <= 20'b0;
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
            delay_cycles <= (delay + 1) * 1000 - 1;
            counting <= 1'b1;
            counter <= 20'b0;
        end

        // Count down
        if (counting) begin
            counter <= counter + 1;
            if (counter == delay_cycles) begin
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

always @(*) begin
    if (counting) begin
        count = delay - (counter / 1000);
    end
    else begin
        count = 4'bxxxx;
    end
end

endmodule
