module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] pattern_buffer;
reg [3:0] delay_counter;
reg [15:0] timer_counter;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        pattern_buffer <= 4'b0;
        delay_counter <= 4'b0;
        timer_counter <= 16'b0;
        delay <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        // Shift in data
        pattern_buffer <= {pattern_buffer[2:0], data};

        // Check for start pattern
        if (pattern_buffer == 4'b1101) begin
            delay_counter <= 4'b0;
            counting <= 1'b1;
            done <= 1'b0;
        end
        // Shift in delay
        else if (counting && delay_counter < 4'd4) begin
            delay_counter <= delay_counter + 1;
            delay[3 - delay_counter] <= data;
        end
        // Count down timer
        else if (counting) begin
            if (timer_counter == 16'd0) begin
                counting <= 1'b0;
                done <= 1'b1;
            end
            else begin
                timer_counter <= timer_counter - 1;
            end
        end
        // Wait for ack
        else if (done && ack) begin
            counting <= 1'b0;
            done <= 1'b0;
        end
    end
end

assign count = delay - timer_counter[15:12];

endmodule
