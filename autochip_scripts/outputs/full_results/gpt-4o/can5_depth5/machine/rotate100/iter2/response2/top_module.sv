module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena == 2'h1) begin
            q <= {q[98:0], q[99]}; // Corrected to preserve MSB during left shift
        end else if (ena == 2'h2) begin
            q <= {q[0], q[99:1]}; // Corrected to preserve LSB during right shift
        end
    end

endmodule
