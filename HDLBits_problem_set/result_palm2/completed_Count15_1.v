module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] q;
    reg [3:0] counter;

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 16) begin
                counter <= 0;
            end
        end
        q <= counter;
    end

endmodule