module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

always @(posedge clk)
begin
    q <= d;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    $monitor("Time=%0t clk=%b d=%b q=%b", $time, clk, d, q);
    
    #100 $finish;
end

endmodule
