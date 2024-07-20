module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);

    reg [9:0] counter;  // 10-bit counter

    always @(posedge clk) begin
        if (load) begin
            counter <= data;  // Load the counter with data
        end else if (counter != 10'b0) begin
            counter <= counter - 1;  // Decrement the counter if it is not 0
        end
    end

    assign tc = (counter == 10'd0);  // tc is high when the counter reaches 0

endmodule
