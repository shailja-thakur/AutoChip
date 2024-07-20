module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Define internal signals
    reg [3:0] q0, q1, q2, q3;

    // Synchronous counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= q0 + (q1 * 10) + (q2 * 100) + (q3 * 1000);
    end

    // Increment enable logic
    always @(posedge clk) begin
        if (reset)
            ena <= 3'b0;
        else
            ena <= {q2, q3};
    end

    // BCD counter logic
    always @(posedge clk) begin
        if (reset)
            q0 <= 4'b0000;
        else if (ena[0])
            q0 <= q0 + 1;
        
        if (reset)
            q1 <= 4'b0000;
        else if (ena[1])
            q1 <= q1 + 1;
        
        if (reset)
            q2 <= 4'b0000;
        else if (ena[2])
            q2 <= q2 + 1;
        
        if (reset)
            q3 <= 4'b0000;
        else
            q3 <= q3 + 1;
    end

endmodule
