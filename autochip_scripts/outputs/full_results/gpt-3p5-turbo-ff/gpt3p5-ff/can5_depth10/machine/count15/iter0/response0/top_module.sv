module top_module(
    input wire clk,
    input wire reset,
    output wire [3:0] q);

    reg [3:0] counter;

    always @(posedge clk) begin
        if (reset)
            counter <= 4'b0;
        else
            counter <= counter + 1;
    end

    assign q = counter;

endmodule
