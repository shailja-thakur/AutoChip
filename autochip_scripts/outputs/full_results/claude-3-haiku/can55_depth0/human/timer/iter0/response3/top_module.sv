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
        tc <= 1'b0; // Reset tc when loading new data
    end
    else if (counter != 0) begin
        counter <= counter - 1;
        tc <= 1'b0; // tc is not asserted until counter reaches 0
    end
    else begin
        tc <= 1'b1; // Assert tc when counter reaches 0
    end
end

endmodule
