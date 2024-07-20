module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            q <= 16'b0; // Reset the register to 0 when reset is low
        end else begin
            if (byteena[0]) begin
                q[7:0] <= d[7:0]; // Write lower 8 bits if byteena[0] is high
            end
            if (byteena[1]) begin
                q[15:8] <= d[15:8]; // Write upper 8 bits if byteena[1] is high
            end
        end
    end

endmodule
