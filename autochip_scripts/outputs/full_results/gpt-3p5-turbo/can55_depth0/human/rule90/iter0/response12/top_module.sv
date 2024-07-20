module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] new_q;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            new_q = q;
            new_q[0] = (q[1] ^ q[0] ^ 1'b0);
            new_q[511] = (q[510] ^ q[511] ^ 1'b0);
            for (int i = 1; i < 511; i = i + 1) begin
                new_q[i] = (q[i-1] ^ q[i] ^ q[i+1]);
            end
            q <= new_q;
        end
    end
    
endmodule
