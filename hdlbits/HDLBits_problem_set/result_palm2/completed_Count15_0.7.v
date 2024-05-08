module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] count = 0;

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end

    assign q = count;

endmodule