module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);

    reg [15:0] dq[15:0];

    always @(posedge clk or posedge resetn) begin
        if (resetn) begin
            dq <= 16'h0;
        end else begin
            if (byteena[1]) begin
                dq[7:0] <= d[7:0];
            end
            if (byteena[0]) begin
                dq[15:8] <= d[15:8];
            end
        end
    end

    assign q = dq;

endmodule