module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter = 0;

always @(posedge clk) begin
    if (load == 1) begin
        counter <= data;
    endelse begin
        if (counter != 0) begin
            counter <= counter - 1;
        endelse begin
            counter <= counter;
        end
    end
end

assign tc = (counter == 0);

endmodule
