module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);

    reg [7:0] q[7:0];
    reg [7:0] d[7:0];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 8; i++) begin
                q[i] <= 0;
            end
        end else begin
            for (int i = 0; i < 8; i++) begin
                q[i] <= d[i];
            end
        end
    end

    assign q = q[7:0];

endmodule