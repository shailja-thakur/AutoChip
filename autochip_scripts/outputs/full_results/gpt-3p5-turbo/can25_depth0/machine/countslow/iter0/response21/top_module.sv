module top_module(
    input wire clk,
    input wire slowena,
    input wire reset,
    output reg [3:0] q
);

    // internal signal to hold the current value of the counter
    reg [3:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 4'b0000;
        end else if (slowena) begin
            if (counter == 4'b1001) begin
                counter <= 4'b0000;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    // assign the value of the counter to the output q
    assign q = counter;

endmodule
