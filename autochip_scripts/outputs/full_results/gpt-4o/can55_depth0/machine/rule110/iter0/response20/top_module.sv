module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);
    wire [511:0] bitwise_operation_result;
    
    assign bitwise_operation_result = 
        ~(
            ((q[511:1] & q[511:0] & {q[510:0], 1'b0}) |
            (~q[511:1] & ~q[511:0] & ~{q[510:0], 1'b0}) |
            (q[511:1] & ~q[511:0] & ~{q[510:0], 1'b0}))
        );

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= bitwise_operation_result;
        end
    end

endmodule
