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

endmodule
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

endmodule
module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);

    reg [9:0] counter = 10'b0;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter != 0) begin
            counter <= counter - 1;
        end
        tc <= (counter == 0);
    end

endmodule
