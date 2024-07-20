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
                2'h1: q <= q << 1;  // Shift left
                2'h2: q <= q >> 1;  // Shift right
                default: q <= q;    // Hold value
            endcase
        end
    end
endmodule
