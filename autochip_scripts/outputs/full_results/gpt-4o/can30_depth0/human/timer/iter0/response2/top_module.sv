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
            tc <= (data == 10'd0) ? 1'b1 : 1'b0;
        end else begin
            if (counter > 10'd0) begin
                counter <= counter - 10'd1;
                tc <= (counter - 10'd1 == 10'd0) ? 1'b1 : 1'b0;
            end else begin
                tc <= 1'b1;
            end
        end
    end

endmodule
