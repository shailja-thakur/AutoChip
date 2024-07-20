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
    end else begin
        if (!counting) begin
            // Look for start pattern 1101
            pattern <= {pattern[2:0], data};
            if (pattern == 4'b1101) begin
                // Shift in delay value
                delay <= {data, delay[3:1]};
                counter <= 16'd1000 * (delay + 1);
                counting <= 1'b1;
            end
        end else begin
            // Counting
            counter <= counter - 1;
            if (counter == 16'b0) begin
                counting <= 1'b0;
                done <= 1'b1;
                while (!ack) begin
                    // Wait for ack
                end
                done <= 1'b0;
            end
        end
    end
end

assign count = (counting) ? delay - (counter / 1000) : 4'bxxxx;

endmodule
