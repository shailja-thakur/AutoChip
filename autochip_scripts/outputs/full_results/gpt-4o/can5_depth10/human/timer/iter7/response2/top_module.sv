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
            tc <= 0; // Ensure tc is cleared when counting down
        end else begin
            counter <= 0; // Maintain counter at 0 when reached
            tc <= 1; // Assert tc when counter reaches 0
        end
    end

endmodule
