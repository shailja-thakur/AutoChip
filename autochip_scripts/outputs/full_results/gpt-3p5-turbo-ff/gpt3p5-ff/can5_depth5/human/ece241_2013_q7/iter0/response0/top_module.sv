module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

// internal wire to hold the value of Qold
wire Qold;

// assign the value of Qold based on the value of Q at the positive clock edge
always @(posedge clk) begin
    Qold <= Q;
end

// define the behavior of the JK flip-flop based on the values of j, k, and Qold
always @(posedge clk) begin
    if (j & ~k)
        Q <= 1'b1;
    else if (~j & k)
        Q <= 1'b0;
    else if (j & k)
        Q <= ~Qold;
end

endmodule
