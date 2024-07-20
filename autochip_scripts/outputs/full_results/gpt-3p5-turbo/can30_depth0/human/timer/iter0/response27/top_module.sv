module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);
    reg [9:0] counter;
    reg tc_temp;

    always @(posedge clk) begin
        if (load == 1) begin
            counter <= data;
        end else if (counter > 0) begin
            counter <= counter - 1;
        end
        if (counter == 0) begin
            tc_temp <= 1;
        end else begin
            tc_temp <= 0;
        end
    end

    assign tc = tc_temp;
endmodule
