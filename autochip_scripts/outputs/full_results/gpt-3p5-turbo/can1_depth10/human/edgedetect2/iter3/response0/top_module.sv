module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_prev;

    always @(posedge clk) begin
        in_prev <= in;
        anyedge <= (in & ~in_prev);
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        #5;
        in = 1;
        #5;
        in = 0;
        #5;
        in = 1;
        #5;
        in = 0;
        #10;
        $finish;
    end

    always #5 clk = ~clk;

endmodule
