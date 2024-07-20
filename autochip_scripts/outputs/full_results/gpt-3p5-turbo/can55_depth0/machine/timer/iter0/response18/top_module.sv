module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter; // Declare a register to hold the counter value

always @(posedge clk) begin
    if (load) begin // If load is asserted
        counter <= data; // Load the new value from data to the counter
    end else if (counter != 0) begin // If counter is not already at 0
        counter <= counter - 1; // Decrement the counter by 1
    end
    tc <= (counter == 0); // Assign tc to 1 if the counter is 0, otherwise assign 0
end

endmodule
