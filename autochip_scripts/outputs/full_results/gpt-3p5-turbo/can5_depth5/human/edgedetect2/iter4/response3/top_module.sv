module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
    prev_in <= in;
end

always @(posedge clk) begin
    anyedge <= in & ~prev_in;
end

initial begin
    $display("Start simulation");
    $dumpfile("wave.vcd");
    $dumpvars(1, top_module);
    $finish(1000);
end

endmodule
