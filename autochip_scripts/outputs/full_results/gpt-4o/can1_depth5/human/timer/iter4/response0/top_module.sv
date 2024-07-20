module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);

    reg [9:0] counter;
    reg tc_reg;

    assign tc = tc_reg;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc_reg <= 0;  // Clear the terminal count flag when a new count is loaded
        end else if (counter > 0) begin
            counter <= counter - 1;
            if (counter == 1)
                tc_reg <= 1;  // tc should be asserted when the counter hits 0 on the next clock cycle
        end else begin
            tc_reg <= 1;  // Make sure tc stays asserted after reaching 0
        end
    end
endmodule
