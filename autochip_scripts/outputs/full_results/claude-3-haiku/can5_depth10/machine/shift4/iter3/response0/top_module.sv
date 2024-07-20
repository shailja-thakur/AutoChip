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
            q <= {q[2:0], 1'b0}; // Shift left by 1 bit, fill with 0
        end
        // No need for an else block, as q will retain its previous value
    end
end

endmodule
