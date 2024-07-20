module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_next; // register to hold the next state of q
    integer i; // loop variable
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 512; i = i + 1) begin
                // left neighbor, handling boundary cases
                if (i == 0) begin
                    q_next[i] = q[1]; // right neighbor
                end else if (i == 511) begin
                    q_next[i] = q[510]; // left neighbor
                end else begin
                    q_next[i] = q[i-1] ^ q[i+1]; // left neighbor ^ right neighbor
                end
            end
            q <= q_next;
        end
    end
endmodule
