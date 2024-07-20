module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] prev_in;

    always @(posedge clk)
    begin
        prev_in <= in;

        // Detect positive edge transition for each bit
        pedge[0] <= (prev_in[0] == 0) && (in[0] == 1);
        pedge[1] <= (prev_in[1] == 0) && (in[1] == 1);
        pedge[2] <= (prev_in[2] == 0) && (in[2] == 1);
        pedge[3] <= (prev_in[3] == 0) && (in[3] == 1);
        pedge[4] <= (prev_in[4] == 0) && (in[4] == 1);
        pedge[5] <= (prev_in[5] == 0) && (in[5] == 1);
        pedge[6] <= (prev_in[6] == 0) && (in[6] == 1);
        pedge[7] <= (prev_in[7] == 0) && (in[7] == 1);
    end

endmodule
