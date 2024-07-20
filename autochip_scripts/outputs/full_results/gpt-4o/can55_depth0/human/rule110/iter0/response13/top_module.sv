module top_module (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] <= (q[511] == 1 && q[0] == 1) || (q[0] == 1 && q[1] == 1) || (q[511] == 0 && q[0] == 1) || (q[0] == 1 && q[1] == 0);
                end else if (i == 511) begin
                    next_q[i] <= (q[510] == 1 && q[511] == 1) || (q[511] == 1 && q[0] == 1) || (q[510] == 0 && q[511] == 1) || (q[511] == 1 && q[0] == 0);
                end else begin
                    next_q[i] <= (q[i-1] && q[i] && q[i+1]) ||
                                 (q[i-1] && q[i] && !q[i+1]) ||
                                 (q[i-1] && !q[i] && q[i+1]) ||
                                 (!q[i-1] && q[i] && q[i+1]);
                end
            end
            q <= next_q;
        end
    end
endmodule
