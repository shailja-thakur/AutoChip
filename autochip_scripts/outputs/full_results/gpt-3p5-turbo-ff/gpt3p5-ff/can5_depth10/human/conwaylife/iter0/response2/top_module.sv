module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (int i = 0; i < 256; i = i + 1) begin
            int sum = 0;
            if (i < 16) begin
                sum = sum + q[i + 240];
                sum = sum + q[i + 16];
            end else if (i >= 240) begin
                sum = sum + q[i - 16];
                sum = sum + q[i - 240];
            end else begin
                sum = sum + q[i - 16];
                sum = sum + q[i + 16];
            end
            if (i % 16 == 0) begin
                sum = sum + q[i + 15];
                sum = sum + q[i + 1];
            end else if (i % 16 == 15) begin
                sum = sum + q[i - 1];
                sum = sum + q[i - 15];
            end else begin
                sum = sum + q[i - 1];
                sum = sum + q[i + 1];
            end

            if (sum == 0 || sum == 1) begin
                next_q[i] = 0;
            end else if (sum == 2) begin
                next_q[i] = q[i];
            end else if (sum == 3) begin
                next_q[i] = 1;
            end else begin
                next_q[i] = 0;
            end
        end
        q <= next_q;
    end
end

endmodule
