module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

// Define the D flip-flop module
module DFF (
    input clk,
    input resetn,
    input d,
    output reg q
);
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule
