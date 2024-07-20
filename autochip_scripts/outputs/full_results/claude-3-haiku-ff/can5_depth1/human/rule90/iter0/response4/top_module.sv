module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    // Internal wires
    wire [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    // Calculate the next state using the Rule 90 logic
    assign next_q[0] = (q[0] ^ q[1]);
    assign next_q[511] = (q[510] ^ q[511]);
    genvar i;
    generate
        for (i = 1; i < 511; i = i + 1) begin : rule90
            assign next_q[i] = (q[i-1] ^ q[i+1]);
        end
    endgenerate

endmodule
