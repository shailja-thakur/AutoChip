module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] new_q;
            integer i;

            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    new_q[i] = q[i + 1]; // q[-1] is 0
                end else if (i == 511) begin
                    new_q[i] = q[i - 1]; // q[512] is 0
                end else begin
                    new_q[i] = q[i - 1] ^ q[i + 1];
                end
            end

            q <= new_q;
        end
    end
endmodule
