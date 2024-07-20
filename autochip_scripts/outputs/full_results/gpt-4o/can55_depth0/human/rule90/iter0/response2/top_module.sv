module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;
            // Boundary cells assume q[-1] and q[512] are both 0 (off)
            next_q[0] = q[1]; // q[-1] is 0, so q[0]'s next state is q[1]
            next_q[511] = q[510]; // q[512] is 0, so q[511]'s next state is q[510]
            
            // Calculate next state for cells between 1 and 510
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ q[i+1];
            end
            
            q <= next_q;
        end
    end
endmodule
