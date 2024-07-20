module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

// Create a temporary register to store the previous value of 'in'
reg [7:0] prev_in;

always @(posedge clk) begin
    // Store the current value of 'in' in 'prev_in'
    prev_in <= in;

    // Detect positive edge transition for each bit
    for (integer i=0; i<8; i=i+1) begin
        if (prev_in[i] == 0 && in[i] == 1) begin
            // Set the output bit 'pedge' to 1 in the next clock cycle
            pedge[i] <= 1;
        end
        else begin
            // Keep the output bit 'pedge' unchanged
            pedge[i] <= 0;
        end
    end
end

endmodule
