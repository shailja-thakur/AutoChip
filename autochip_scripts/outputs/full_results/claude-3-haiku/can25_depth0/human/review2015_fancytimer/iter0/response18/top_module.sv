module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam START_PATTERN = 4'b1101;
localparam DELAY_BITS = 4;

reg [3:0] shift_reg;
reg [3:0] delay;
reg [19:0] counter;

always @(posedge clk) begin
    if (reset) begin
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        // Shift in data
        shift_reg <= {shift_reg[2:0], data};

        // Check for start pattern
        if (shift_reg == START_PATTERN) begin
            // Shift in delay
            for (int i = 0; i < DELAY_BITS; i++) begin
                shift_reg <= {shift_reg[2:0], data};
                delay[DELAY_BITS-1-i] <= shift_reg[3];
            end

            // Start counting
            counter <= 0;
            counting <= 1;
        end

        // Count down
        if (counting) begin
            counter <= counter + 1;
            if (counter == (delay + 1) * 1000 - 1) begin
                counting <= 0;
                done <= 1;
            end
        end

        // Wait for acknowledge
        if (done && ack) begin
            done <= 0;
        end
    end
end

assign count = counting ? delay - (counter / 1000) : 0;

endmodule
