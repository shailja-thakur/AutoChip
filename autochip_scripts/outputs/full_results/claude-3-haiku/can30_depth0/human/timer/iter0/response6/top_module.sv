module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        // (1) If load = 1, load the internal counter with the 10-bit data
        counter <= data;
    end
    else begin
        // (2) If load = 0, the internal counter should decrement by 1
        if (counter != 0) begin
            counter <= counter - 1;
        end
    end
end

// The output signal tc ("terminal count") indicates whether the internal counter has reached 0
assign tc = (counter == 0);

endmodule
