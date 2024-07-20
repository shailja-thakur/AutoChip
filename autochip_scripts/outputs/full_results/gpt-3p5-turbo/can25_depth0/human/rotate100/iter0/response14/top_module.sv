module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            if (ena[1] && ena[0]) begin
                // No rotation
                q <= q;
            end else if (ena[1]) begin
                // Rotate left by one bit
                q <= {q[98:0], q[99]};
            end else if (ena[0]) begin
                // Rotate right by one bit
                q <= {q[0], q[99:1]};
            end else begin
                // No rotation
                q <= q;
            end
        end
    end

endmodule
