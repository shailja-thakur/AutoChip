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
reg [11:0] counter;

always @(posedge clk) begin
    if (reset) begin
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 12'b0000_0000_0000;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        // Shift in the data bit
        pattern <= {pattern[2:0], data};

        // Check for the start pattern 1101
        if (pattern == 4'b1101) begin
            // Shift in the delay bits
            delay <= {data, data, data, data};
            counter <= 12'b0000_0000_0000;
            counting <= 1'b1;
        end

        // Increment the counter
        if (counting) begin
            counter <= counter + 1;
            if (counter == (delay + 1) * 12'b1000_0000_0000) begin
                counting <= 1'b0;
                done <= 1'b1;
            end
        end

        // Wait for the user to acknowledge the timer
        if (done && ack) begin
            done <= 1'b0;
        end
    end
end

assign count = counter[11:8];

endmodule
