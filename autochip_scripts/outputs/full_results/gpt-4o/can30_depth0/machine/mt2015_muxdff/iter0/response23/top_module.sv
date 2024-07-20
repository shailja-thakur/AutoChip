module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    // Initial value of output register Q to 0
    initial begin
        Q = 0;
    end

    // On rising edge of clock, evaluate the select signal and choose the appropriate input
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
