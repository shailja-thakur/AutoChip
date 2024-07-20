module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_prev;

    always @(posedge clk) begin
        for (integer i = 0; i < 8; i = i + 1) begin
            // Detect rising edge
            if (!in_prev[i] && in[i]) begin
                anyedge[i] <= 1'b1;
            end 

            // Detect falling edge
            else if (in_prev[i] && !in[i]) begin
                anyedge[i] <= 1'b0;
            end 

            // Output remains unchanged if there is no edge
            else begin
                anyedge[i] <= anyedge[i];
            end

            in_prev[i] <= in[i];
        end
    end

endmodule
