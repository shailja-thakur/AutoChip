module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_prev;

    always @(posedge clk) begin
        // Detect rising edge
        if (!in_prev[0] && in[0]) begin
            anyedge[0] <= 1'b1;
        end else begin
            anyedge[0] <= 1'b0;
        end

        // Detect falling edge
        if (in_prev[0] && !in[0]) begin
            anyedge[0] <= 1'b1;
        end
        
        in_prev[0] <= in[0];
    end

    always @(posedge clk) begin
        // Detect rising edge
        if (!in_prev[1] && in[1]) begin
            anyedge[1] <= 1'b1;
        end else begin
            anyedge[1] <= 1'b0;
        end

        // Detect falling edge
        if (in_prev[1] && !in[1]) begin
            anyedge[1] <= 1'b1;
        end
        
        in_prev[1] <= in[1];
    end

    // Repeat the above block of code for all 8 bits

endmodule
