module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        counter <= data;  // Load the counter with data
    end 
    else if (counter != 10'b0) begin
        counter <= counter - 10'b1;  // Decrement the counter
    end

    if (counter == 10'b0) begin
        tc <= 1'b1;  // Assert tc when counter reaches 0
    end 
    else begin
        tc <= 1'b0;  // Deassert tc otherwise
    end
end

endmodule
