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
reg [9:0] timer_count;

always @(posedge clk) begin
    if (reset) begin
        shift_reg <= 4'b0;
        delay <= 4'b0;
        timer_count <= 10'd0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        if (!counting) begin
            // Shift in data to detect start pattern
            shift_reg <= {shift_reg[2:0], data};
            if (shift_reg == START_PATTERN) begin
                // Start pattern detected, shift in delay
                delay <= {data, shift_reg[3:1]};
                counting <= 1'b1;
                timer_count <= 10'd0;
            end
        end else begin
            // Counting
            timer_count <= timer_count + 10'd1;
            if (timer_count == (({1'b0, delay} + 10'b1) * 10'd1000 - 10'd1)) begin
                // Counting complete
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

assign count = counting ? delay - (timer_count / 10'd1000) : 4'bxxxx;

endmodule
