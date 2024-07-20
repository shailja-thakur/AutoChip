module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);

reg [9:0] counter;
reg tc;

always @(posedge clk) begin
    if (load) begin
        counter <= data;
    end else begin
        if (counter > 0) begin
            counter <= counter - 1;
        end else begin
            counter <= 0;
        end
    end
end

assign tc = (counter == 0);

endmodule
