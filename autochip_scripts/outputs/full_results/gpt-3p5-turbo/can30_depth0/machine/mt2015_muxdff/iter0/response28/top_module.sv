module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    always @(posedge clk) begin
        if (L) // Select signal is high
            Q <= r_in;
        else // Select signal is low
            Q <= q_in;
    end

endmodule
