module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            // Calculate the feedback bit
            wire feedback = q[31] ^ q[21] ^ q[1] ^ q[0];
            // Shift the register and insert the feedback bit at the least significant position
            q <= {q[30:0], feedback};
        end
    end
endmodule
