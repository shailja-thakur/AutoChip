module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

wire [511:0] q_temp;

// Rule 110 logic
genvar i;
generate
    for (i = 0; i < 512; i = i + 1) begin : RULE_110
        always @(*) begin
            case (i)
                0: q_temp[i] = (q[1] & q[0] & ~q[511]);
                1 to 510: q_temp[i] = (~(q[i - 1] & q[i] & q[i + 1]) | (q[i] & ~q[i - 1]));
                511: q_temp[i] = (q[510] & q[511] & ~q[0]);
            endcase
        end
    end
endgenerate

// Load data
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
end

// Update q
always @(posedge clk) begin
    q <= q_temp;
end

endmodule
