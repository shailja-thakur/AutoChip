module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (ena)
                2'h1: q <= {q[98:0], 1'b0}; // Left shift with zero padding
                2'h2: q <= {1'b0, q[99:1]};  // Right shift with zero padding
                default: q <= q;
            endcase
        end
    end

endmodule
