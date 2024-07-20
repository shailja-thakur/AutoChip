module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter;
reg tc_reg;

always @(posedge clk) begin
    if (load) begin
        counter <= data;
        tc_reg <= 0;
    end
    else begin
        if (counter == 0)
            tc_reg <= 1;
        else
            counter <= counter - 1;
    end
end

assign tc = tc_reg;

endmodule
