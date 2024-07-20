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
            // q should remain unchanged when neither load nor ena is active
            q <= q;
        end
    end
end

endmodule
