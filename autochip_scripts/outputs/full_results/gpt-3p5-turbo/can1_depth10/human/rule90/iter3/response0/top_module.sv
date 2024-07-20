module top_module(
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q);
  
    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            next_q[0] <= q[1] ^ q[511];
            for (int i = 1; i < 511; i = i+1) begin
                next_q[i] <= q[i-1] ^ q[i+1];
            end
            next_q[511] <= q[510] ^ 0; // Fix boundary condition
            q <= next_q;
        end
    end
endmodule
