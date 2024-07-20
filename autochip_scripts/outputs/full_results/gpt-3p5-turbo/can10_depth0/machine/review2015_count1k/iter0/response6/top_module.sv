module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    // internal signal to hold the current value of the counter
    reg [9:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            // reset the counter to 0 if reset input is active
            counter <= 0;
        end else begin
            if (counter == 999) begin
                // reset the counter to 0 if it reaches 999
                counter <= 0;
            end else begin
                // increment the counter by 1
                counter <= counter + 1;
            end
        end
    end

    // output the current value of the counter
    assign q = counter;

endmodule
