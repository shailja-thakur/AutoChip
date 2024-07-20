module top_module (
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

// Always block sensitive to the rising edge of the clock and asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset)
        q <= 4'b0000;  // Asynchronous reset: Set output to 0
    else if (load)
        q <= data;  // Load data into output if load signal is active
    else if (ena)
        q <= {q[2:0], 1'b0};  // Shift output register left by 1 bit if enable signal is active
    else
        q <= q;    // Maintain current state if no condition is met
end

endmodule
