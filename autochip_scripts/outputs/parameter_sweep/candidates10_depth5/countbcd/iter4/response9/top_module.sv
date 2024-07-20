module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 16'b0000;
        else if (ena[1] && q[3:0] == 4'b1001)
            q[3:0] <= 4'b0000;
        else if (ena[2] && q[7:4] == 4'b1001)
            q[7:4] <= 4'b0000;
        else if (ena[3] && q[11:8] == 4'b1001)
            q[11:8] <= 4'b0000;
        else
            q <= q + 4'b0001;
    end

    always @(posedge clk) begin
        if (reset)
            ena <= 3'b000;
        else 
            ena <= {q[15:13]} != 3'b111;
    end

endmodule
module top_module_tb();
    reg clk;
    reg reset;
    wire [3:1] ena;
    wire [15:0] q;

    top_module dut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .q(q)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        #100 $finish;
    end

endmodule
