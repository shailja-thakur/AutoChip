module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                // Handle boundary conditions
                reg left, center, right;
                if (i == 0) begin
                    left = 0;
                    center = q[i];
                    right = q[i+1];
                end
                else if (i == 511) begin
                    left = q[i-1];
                    center = q[i];
                    right = 0;
                end
                else begin
                    left = q[i-1];
                    center = q[i];
                    right = q[i+1];
                end     
                // Compute next state based on Rule 110
                next_q[i] = (left & center & right) ? 0 :
                            (left & center & ~right) ? 1 :
                            (left & ~center & right) ? 1 :
                            (left & ~center & ~right) ? 0 :
                            (~left & center & right) ? 1 :
                            (~left & center & ~right) ? 1 :
                            (~left & ~center & right) ? 1 :
                            0;
            end
            q <= next_q;
        end
    end
endmodule
