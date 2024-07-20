module top_module(
    input clk,
    input reset,
    output reg shift_ena);  // Added reg keyword to make shift_ena a register 

    reg [3:0] counter;  // Counter to count the clock cycles

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;  // Assert shift_ena when reset is high
            counter <= 0;   // Reset the counter
        end else begin
            if (shift_ena && counter < 4) begin
                shift_ena <= 1;  // Keep shift_ena high for 4 clock cycles
                counter <= counter + 1;  // Increment the counter
            end else begin
                shift_ena <= 0;  // Set shift_ena to 0 after 4 clock cycles
                counter <= 0;   // Reset the counter
            end
        end
    end

endmodule
