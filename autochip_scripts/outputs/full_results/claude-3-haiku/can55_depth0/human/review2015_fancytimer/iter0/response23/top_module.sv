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
reg [3:0] bit_count;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        bit_count <= 0;
        pattern <= 0;
    end
    else begin
        // Detect the start pattern 1101
        pattern <= {pattern[2:0], data};
        if (pattern == 4'b1101) begin
            bit_count <= 0;
            counting <= 1;
        end

        // Shift in the delay value
        if (counting && bit_count < 4) begin
            delay[3-bit_count] <= data;
            bit_count <= bit_count + 1;
        end

        // Count down the timer
        if (counting && bit_count == 4) begin
            counter <= delay;
            if (counter == 0) begin
                counting <= 0;
                done <= 1;
            end
            else begin
                counter <= counter - 1;
            end
        end

        // Wait for acknowledgement
        if (done && ack) begin
            done <= 0;
        end
    end
end

assign count = (counting) ? counter : delay;

endmodule
