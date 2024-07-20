module top_module(
    input clk,
    input d,
    output reg q);

// Positive edge triggered flip-flop
always @(posedge clk) begin
    q <= d;
end

// Additional logic to capture the negative edge trigger
reg q_negedge;
always @(negedge clk) begin
    q_negedge <= d;
end

// Logic to update the output q on both edges of the clock
always @(posedge clk or negedge clk) begin
    if (~clk) begin
        q <= q_negedge;
    end
end

endmodule
