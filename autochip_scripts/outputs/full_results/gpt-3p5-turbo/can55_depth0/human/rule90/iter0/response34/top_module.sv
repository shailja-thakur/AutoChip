module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal wires to hold the next state of each cell
    wire [511:0] next_state;

    // Assign next state for each cell based on the rules
    genvar i;
    generate
        for (i = 0; i < 512; i = i + 1) begin: rule90
            assign next_state[i] = (q[i-1] ^ q[i+1]);
        end
    endgenerate

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end
endmodule
