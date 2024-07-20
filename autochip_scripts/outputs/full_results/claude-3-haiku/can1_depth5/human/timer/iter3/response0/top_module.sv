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
        tc <= 0;
    end
    else if (counter != 0) begin
        counter <= counter - 1;
        tc <= (counter == 1); // Assign tc to 1 when counter is 1, not 0
    end
    else begin
        tc <= 1;
    end
end

endmodule
