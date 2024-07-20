module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    always @(posedge clk) begin
        if (load) 
            q <= data; // Load data into q when load is high
        else begin
            case (ena)
                2'h1: q <= q << 1; // Shift left
                2'h2: q <= q >> 1; // Shift right
                default: q <= q; // Maintain current state when ena is 0 or any other value
            endcase
        end
    end
endmodule
