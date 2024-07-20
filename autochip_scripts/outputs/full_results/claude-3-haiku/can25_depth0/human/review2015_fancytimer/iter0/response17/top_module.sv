module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] shift_reg; // Shift register to store the start pattern and duration
reg [15:0] timer_count; // 16-bit counter to count the timer duration
reg [3:0] delay; // Delay value from the shift register

// Shift register to capture the start pattern and duration
always @(posedge clk) begin
    if (reset) begin
        shift_reg <= 0;
    end else begin
        shift_reg <= {shift_reg[2:0], data};
    end
end

// Timer control logic
always @(posedge clk) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        timer_count <= 0;
        delay <= 0;
    end else begin
        // Start the timer when the pattern 1101 is detected
        if (shift_reg == 4'b1101) begin
            delay <= shift_reg[3:0]; // Store the delay value
            counting <= 1; // Indicate that the timer is counting
            timer_count <= 0; // Reset the timer count
        end

        // Increment the timer count
        if (counting) begin
            timer_count <= timer_count + 1;

            // Check if the timer has finished counting
            if (timer_count == (delay + 1) * 1000) begin
                counting <= 0; // Stop the timer
                done <= 1; // Indicate that the timer has finished
            end
        end

        // Wait for the user to acknowledge the timer
        if (done && ack) begin
            done <= 0; // Reset the done flag
        end
    end
end

// Output the current remaining time
assign count = delay - (timer_count / 1000);

endmodule
