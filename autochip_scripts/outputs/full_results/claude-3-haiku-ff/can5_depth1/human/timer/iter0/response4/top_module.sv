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
        tc <= 1'b0; // Clear the tc signal when the counter is loaded
    end
    else begin
        if (counter > 0) begin
            counter <= counter - 1;
            tc <= 1'b0; // tc signal is not asserted while counter is counting down
        end
        else begin
            tc <= 1'b1; // Assert the tc signal when the counter reaches 0
        end
    end
end

endmodule
