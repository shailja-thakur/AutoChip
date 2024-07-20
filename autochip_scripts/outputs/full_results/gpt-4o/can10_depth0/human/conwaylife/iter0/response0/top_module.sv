module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        reg [3:0] x, y;
        reg [3:0] xi, yi;
        reg [3:0] cnt;
        reg [255:0] new_q;
        for (y = 0; y < 16; y = y + 1) begin
            for (x = 0; x < 16; x = x + 1) begin
                cnt = 0;
                for (yi = (y == 0 ? 15 : y - 1); yi <= (y == 15 ? 16 : y + 1); yi = yi + 1) begin
                    for (xi = (x == 0 ? 15 : x - 1); xi <= (x == 15 ? 16 : x + 1); xi = xi + 1) begin
                        if (yi != y || xi != x) begin
                            cnt = cnt + q[yi * 16 + xi % 16];
                        end
                    end
                end
                if (cnt < 2 || cnt > 3) begin
                    new_q[y * 16 + x] = 0;
                end else if (cnt == 3) begin
                    new_q[y * 16 + x] = 1;
                end else begin
                    new_q[y * 16 + x] = q[y * 16 + x];
                end
            end
        end
        q <= new_q;
    end
end

endmodule
