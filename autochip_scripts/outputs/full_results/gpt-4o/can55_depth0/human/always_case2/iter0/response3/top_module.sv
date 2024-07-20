module top_module (
    input [3:0] in,
    output reg [1:0] pos
);
    always @(*) begin
        if (in[3]) begin
            pos = 2'd3;
        end else if (in[2]) begin
            pos = 2'd2;
        end else if (in[1]) begin
            pos = 2'd1;
        end else if (in[0]) begin
            pos = 2'd0;
        end else begin
            pos = 2'd0; // No bits are high
        end
    end
endmodule
