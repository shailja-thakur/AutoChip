module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc <= 0;
        end else if (counter > 0) begin
            counter <= counter - 1;
            tc <= (counter == 1) ? 1'b1 : 1'b0; // tc asserted when counter reaches 0
        end
    end

    // Ensure tc remains asserted once counter reaches 0
    always @(counter) begin
        if (counter == 0) begin
            tc <= 1'b1;
        end
    end
endmodule
