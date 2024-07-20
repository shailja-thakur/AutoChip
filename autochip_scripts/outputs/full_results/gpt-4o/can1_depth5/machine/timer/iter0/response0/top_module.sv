module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);

    reg [9:0] counter;  // 10-bit register for the counter

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with the value from data
        end else if (counter != 0) begin
            counter <= counter - 1; // Decrement the counter
        end
    end

    assign tc = (counter == 0); // Assert tc when counter is 0

endmodule
