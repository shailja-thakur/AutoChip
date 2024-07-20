module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);
    reg [9:0] counter;
    reg [9:0] next_counter; // Fix: Added next_counter variable

    always @(posedge clk) begin
        if (load == 1'b1) begin
            next_counter <= data;
        end else if (counter != 10'd0) begin
            next_counter <= counter - 1;
        end
    end

    always @(posedge clk) begin
        counter <= next_counter; // Fix: Use next_counter in the sequential always block
        tc <= (counter == 10'd0);
    end
endmodule
