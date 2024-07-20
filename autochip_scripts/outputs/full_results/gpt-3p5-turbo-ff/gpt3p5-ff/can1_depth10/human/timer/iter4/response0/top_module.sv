module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

    reg [9:0] counter;
    reg [9:0] next_counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc <= 0;
        end
        else if (counter > 0) begin
            next_counter <= counter - 1;
        end
    end

    always @(posedge clk) begin
        counter <= next_counter;
        if (counter == 0) begin
            tc <= 1;
        end
        else begin
            tc <= 0;
        end
    end

endmodule
