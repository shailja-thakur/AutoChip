module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter;
reg tc_out;
always @(posedge clk) begin
    if (load) begin
        counter <= data;
        tc_out <= 0;
    end else if (counter > 0) begin
        counter <= counter - 1;
        tc_out <= 0;
    end else begin
        tc_out <= 1;
    end
end

assign tc = tc_out;

endmodule
