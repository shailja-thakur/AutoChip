module top_module(
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            // Load the counter with the 10-bit data
            counter <= data;
            tc <= 0;
        end else begin
            if (counter != 0) begin
                // Decrement the counter if it's not zero
                counter <= counter - 1;

                // Check if the counter reaches 0
                if (counter == 1) begin
                    tc <= 1;
                end
            end
        end
    end
endmodule
