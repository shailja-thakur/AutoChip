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
                2'h1: q <= q << 1;
                2'h2: q <= q >> 1;
                default: q <= q; // No operation
            endcase
        end
    end

endmodule
