module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0; // Assign 0 to q when reset is high
        end else begin
            q <= d; // Assign the value of d to q
        end
    end

endmodule
