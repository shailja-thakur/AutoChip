module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);
    // Internal register to store the counter value
    reg [9:0] counter = 10'b0;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter != 10'b0) begin
            counter <= counter - 1;
        end
    end

    // Assign tc to indicate when counter is zero
    assign tc = (counter == 10'b0);

endmodule
