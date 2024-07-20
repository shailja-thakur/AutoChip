module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            case (ena)
                2'b01: q <= {q[98:0], 1'b0};
                2'b10: q <= {1'b0, q[99:1]};
                default: q <= q;
            endcase
        end
    end
endmodule
