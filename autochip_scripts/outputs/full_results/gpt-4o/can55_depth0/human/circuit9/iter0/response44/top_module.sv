module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1)
            q <= 3'b100;
        else if (a == 0 && q == 4)
            q <= 5;
        else if (a == 0 && q >= 5 && q < 7)
            q <= q + 1;
        else if (a == 0 && q == 7)
            q <= 3'b000; // reset to 0 after reaching 7
        else
            q <= q + 1;
    end
endmodule
