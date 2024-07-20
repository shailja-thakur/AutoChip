module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

`timescale 1ns/1ps

always @(*) begin
    Y2 = y[1] & ~w;
    Y4 = y[6] & y[5] & y[3] & y[2] & w;
end

initial begin
    $monitor("Time = %0t, Y2 = %b, Y4 = %b", $time, Y2, Y4);
    Y2 = 0; // initialize outputs
    Y4 = 0;
    #10; // wait for 10 time units
    $finish; // end simulation
end

endmodule
