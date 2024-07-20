module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);
    reg [9:0] counter;

    // Always block triggered on rising edge of clk
    always @(posedge clk) begin
        if (load) begin
            counter <= data;  // Load the counter with the value from data
        end else if (counter != 0) begin
            counter <= counter - 1;  // Decrement the counter if it's not zero
        end
    end

    // Output logic for tc
    assign tc = (counter == 0);

endmodule
