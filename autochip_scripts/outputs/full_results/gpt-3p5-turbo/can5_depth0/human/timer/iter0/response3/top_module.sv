module top_module (
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter;
reg tc;

always @(posedge clk) begin
    if (load == 1)
        counter <= data;
    else if (counter > 0)
        counter <= counter - 1;

    if (counter == 0)
        tc <= 1;
    else
        tc <= 0;
end

endmodule
