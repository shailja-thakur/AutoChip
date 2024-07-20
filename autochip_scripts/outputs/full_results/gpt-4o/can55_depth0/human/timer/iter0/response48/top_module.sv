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
        end else if (counter > 0) begin
            counter <= counter - 1;
        end else begin
            counter <= counter;  // once counter reaches 0, it stays 0
        end
    end

    always @(*) begin
        if (counter == 0) begin
            tc = 1;
        end else begin
            tc = 0;
        end
    end

endmodule
