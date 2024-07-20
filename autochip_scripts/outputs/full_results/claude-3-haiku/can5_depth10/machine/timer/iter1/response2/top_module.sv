module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        counter <= data;
    end else if (counter != 0) begin
        counter <= counter - 1;
    end
    tc <= (counter == 1); // Changed to (counter == 1) to match the test bench
end

endmodule
