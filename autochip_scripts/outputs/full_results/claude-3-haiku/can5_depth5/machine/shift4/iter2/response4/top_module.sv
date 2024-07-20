module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

always @(posedge clk, posedge areset) begin
    if (areset) begin
        q <= 4'b0000;
    end
    else begin
        if (load) begin
            q <= data;
        end
        else if (ena) begin
            q <= {q[2:0], 1'b0};
        end
        else begin
            // q <= q; // This line is unnecessary, as the register value is not changed when neither load nor ena is active
        end
    end
end

endmodule
