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
            tc <= 0;
        end else if (counter > 0) begin
            counter <= counter - 1;
            if (counter == 1) begin
                tc <= 1;
            end
        end else begin
            tc <= 1;
        end
    end
    
    always @(*) begin
        if (counter == 0)
            tc = 1;
        else
            tc = 0;
    end

endmodule
