module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter != 10'b0000000000) begin
            counter <= counter - 1;
        end
    end

    always @(posedge clk or posedge load) begin
        if (load)
            tc <= 0;
        else if (counter == 10'b0000000000)
            tc <= 1;
        else
            tc <= 0;
    end
endmodule
