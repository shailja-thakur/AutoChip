module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam [3:0] START_PATTERN = 4'b1101;

reg [3:0] shift_reg;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        // Shift in new bit
        shift_reg <= {shift_reg[2:0], data};

        // Check for start pattern
        if (shift_reg == START_PATTERN) begin
            // Shift in delay
            delay <= {data, shift_reg[3:1]};
            counter <= 0;
            counting <= 1;
        end

        // Counting
        if (counting) begin
            counter <= counter + 1;
            if (counter == (delay + 1) * 1000 - 1) begin
                counting <= 0;
                done <= 1;
            end
        end

        // Acknowledge
        if (done && ack) begin
            done <= 0;
        end
    end
end

assign count = counting ? delay - (counter / 1000) : 4'bxxxx;

endmodule
