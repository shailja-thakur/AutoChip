module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 4'b0000; // When asynchronous reset is active, set output register to 0
    end
    else begin
        if (load) begin
            q <= data; // When load signal is active, load data input into output register
        end
        else if (ena) begin
            q <= {q[2:0], 1'b0}; // When enable signal is active, shift output register left by 1 bit
        end
        // When none of the signals are active, the output register remains unchanged
    end
end

endmodule
