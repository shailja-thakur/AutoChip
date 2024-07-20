module top_module (
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

    // always block for synchronous reset and load
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 0;
        end else if (load) begin
            q <= data;
        end else begin
            if (ena) begin
                q <= {q[2:0], ena};
            end else begin
                q <= q;
            end
        end
    end

endmodule
