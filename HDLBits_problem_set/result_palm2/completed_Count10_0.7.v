module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 10) begin
                counter <= 0;
            end
        end
    end

    assign q = counter;

endmodule