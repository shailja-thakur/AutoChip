module top_module(
    input wire clk,
    input wire reset,
    output reg [3:1] ena,
    output reg [15:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else begin
            if (ena[1])
                q[3:0] <= q[3:0] + 1;
            if (ena[2])
                q[7:4] <= q[7:4] + 1;
            if (ena[3])
                q[11:8] <= q[11:8] + 1;
        end
    end
    
    initial begin
        ena <= 0;
        #20 reset <= 1;
        #10 reset <= 0;
        #100 ena <= 1;
        #200 ena <= 2;
        #300 ena <= 4;
        #400 ena <= 3;
        #500 $finish;
    end
    
endmodule
