module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        case (ena)
            2'b01: // Rotate right
                q <= {q[0], q[99:1]};
            2'b10: // Rotate left
                q <= {q[98:0], q[99]};
            default: // No rotation
                q <= q;
        endcase
    end
end

endmodule
