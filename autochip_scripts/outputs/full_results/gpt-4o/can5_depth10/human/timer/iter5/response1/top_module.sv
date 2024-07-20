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
                tc <= 1; // tc should be set only when counter is about to reach 0 on the next clock edge.
            end else begin
                tc <= 0;
            end
        end else begin
            tc <= 1; // Ensure tc remains high until next load
        end
    end

endmodule
