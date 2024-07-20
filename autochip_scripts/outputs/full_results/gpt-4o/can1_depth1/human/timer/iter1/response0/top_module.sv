module top_module (
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc <= 0;  // Reset the tc signal when loading new data
        end else if (counter > 0) begin
            counter <= counter - 1;
            if (counter == 1) begin
                tc <= 1;  // Assert tc when the counter will reach 0 on the next clock
            end else begin
                tc <= 0;
            end
        end else begin
            tc <= 1;  // tc should remain asserted if the counter is 0
        end
    end

endmodule
