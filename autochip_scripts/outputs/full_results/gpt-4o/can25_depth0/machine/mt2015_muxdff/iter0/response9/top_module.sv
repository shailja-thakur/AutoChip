module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    initial begin
        Q = 0;  // Set initial value of Q to 0
    end
    
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;  // Set Q to r_in when L is high
        end else begin
            Q <= q_in;  // Set Q to q_in when L is low
        end
    end

endmodule
