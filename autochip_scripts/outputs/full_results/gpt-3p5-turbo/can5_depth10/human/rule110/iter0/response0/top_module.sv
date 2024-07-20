module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[511] = 0; // Left boundary
            for (int i = 0; i < 511; i = i + 1) begin
                q[i] = rule110(q[i-1], q[i], q[i+1]);
            end
            q[0] = rule110(0, q[0], q[1]);
            q[511] = 0; // Right boundary
        end
    end

    function rule110(input left, input center, input right);
        case({left, center, right})
            3'b111: rule110 = 1'b0;
            3'b110: rule110 = 1'b1;
            3'b101: rule110 = 1'b1;
            3'b100: rule110 = 1'b0;
            3'b011: rule110 = 1'b1;
            3'b010: rule110 = 1'b1;
            3'b001: rule110 = 1'b1;
            3'b000: rule110 = 1'b0;
        endcase
    endfunction

endmodule
