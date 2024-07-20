module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

// Define internal signal for intermediate operations
reg [15:0] internal_q;

always @(posedge clk) begin
    if (resetn == 0) begin
        internal_q <= 16'h0000; // Reset the register to 0
    end else begin
        if (byteena[0] == 1'b1) begin
            internal_q[7:0] <= d[7:0]; // Write lower 8 bits of d to lower 8 bits of internal_q
        end
        if (byteena[1] == 1'b1) begin
            internal_q[15:8] <= d[15:8]; // Write upper 8 bits of d to upper 8 bits of internal_q
        end
    end
end

assign q = internal_q;

endmodule
