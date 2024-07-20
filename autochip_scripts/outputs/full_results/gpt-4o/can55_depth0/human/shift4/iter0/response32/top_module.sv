module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset, q is set to 0
        end else begin
            if (load) begin
                q <= data; // Synchronous load, q is set to data
            end else if (ena) begin
                q <= {q[2:0], 1'b0}; // Synchronous shift right, q[3:1] shift right, q[0] is 0
            end
        end
    end
endmodule
