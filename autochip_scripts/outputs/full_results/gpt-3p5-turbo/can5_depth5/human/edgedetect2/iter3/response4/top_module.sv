module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
    anyedge <= in & ~prev_in;
    prev_in <= in;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    $display("Simulation started");
    #100;
    $display("Simulation finished");
    $finish;
end

endmodule
