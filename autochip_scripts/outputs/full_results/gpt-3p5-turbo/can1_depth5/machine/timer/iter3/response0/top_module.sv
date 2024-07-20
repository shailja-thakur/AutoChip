module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load == 1'b1) begin
            counter <= data;
        end else if (counter != 10'd0) begin // Fix: changed from 0 to 10'd0
            counter <= counter - 1;
        end
        tc <= (counter == 10'd0); // Fix: changed from 0 to 10'd0
    end
endmodule
