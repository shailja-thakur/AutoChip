module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

// Declare the 16 D flip-flops
reg [7:0] q_lower;
reg [7:0] q_upper;

always @(posedge clk) begin
    if (~resetn) begin
        q_lower <= 8'b0;
        q_upper <= 8'b0;
    end
    else begin
        // Update the lower byte
        if (byteena[0])
            q_lower <= d[7:0];
        // Update the upper byte
        if (byteena[1])
            q_upper <= d[15:8];
    end
end

// Combine the upper and lower bytes into the output
always @(*) begin
    q = {q_upper, q_lower};
end

endmodule
