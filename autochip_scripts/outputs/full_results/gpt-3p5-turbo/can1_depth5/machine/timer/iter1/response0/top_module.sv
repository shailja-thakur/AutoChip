module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc // Fix: changed from wire to reg
);
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load == 1'b1) begin
            counter <= data;
        end else if (counter != 0) begin
            counter <= counter - 1;
        end
        tc <= (counter == 0);
    end
endmodule
