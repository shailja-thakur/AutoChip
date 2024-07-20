module top_module(
    input wire clk,
    input wire reset,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // set q to 1 when reset is active
        end else if (q == 4'b1010) begin
            q <= 4'b0001; // reset q to 1 when q reaches 10
        end else begin
            q <= q + 1; // increment q by one
        end
    end

endmodule
