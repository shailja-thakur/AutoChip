module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);
    reg [9:0] counter;
    reg [9:0] next_counter;

    always @(posedge clk) begin
        if (load == 1'b1) begin
            next_counter <= data;
        end else if (counter != 10'd0) begin
            next_counter <= counter - 10'd1; // Fix: Decrease by 10'd1 instead of 1
        end
    end

    always @(posedge clk) begin
        counter <= next_counter;
        tc <= (counter == 10'd0);
    end
endmodule
