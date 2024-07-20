module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            integer i;
            reg [511:0] q_next;
            
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    q_next[i] = q[1]; // left boundary assumed to be zero
                end
                else if (i == 511) begin
                    q_next[i] = q[510]; // right boundary assumed to be zero
                end
                else begin
                    q_next[i] = q[i-1] ^ q[i+1];
                end
            end

            q <= q_next;
        end
    end
endmodule
