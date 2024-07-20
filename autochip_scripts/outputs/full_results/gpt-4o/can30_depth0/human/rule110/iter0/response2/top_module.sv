module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            reg [511:0] next_q;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    next_q[i] = (q[1] == 1'b1);  // q[-1] is considered to be 0
                else if (i == 511)
                    next_q[i] = (q[510:509] == 2'b01 || q[510:509] == 2'b10 || q[510:509] == 2'b11);  // q[512] is considered to be 0
                else
                    next_q[i] = (q[i-1:i+1] == 3'b011 || q[i-1:i+1] == 3'b101 || q[i-1:i+1] == 3'b110 || q[i-1:i+1] == 3'b001);
            end
            q <= next_q;
        end
    end

endmodule
