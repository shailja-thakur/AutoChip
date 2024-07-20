module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initialize the output register to 0
    initial Q = 0;

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
