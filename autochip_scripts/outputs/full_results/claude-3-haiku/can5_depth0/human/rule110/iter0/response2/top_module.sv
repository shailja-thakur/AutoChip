module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q[511] <= 0; // Left boundary is 0
        q[0] <= 0; // Right boundary is 0
        for (int i = 1; i < 511; i = i + 1) begin
            case ({q[i-1], q[i], q[i+1]})
                3'b111: q[i] <= 0;
                3'b110: q[i] <= 1;
                3'b101: q[i] <= 1;
                3'b100: q[i] <= 0;
                3'b011: q[i] <= 1;
                3'b010: q[i] <= 1;
                3'b001: q[i] <= 1;
                3'b000: q[i] <= 0;
            endcase
        end
    end
end

endmodule
