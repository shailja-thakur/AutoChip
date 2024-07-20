module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            if (ena == 2'b01) begin
                q <= {q[97:0], 2'b00};
            end else if (ena == 2'b10) begin
                q <= {2'b00, q[99:2]};
            end
        end
    end

endmodule
