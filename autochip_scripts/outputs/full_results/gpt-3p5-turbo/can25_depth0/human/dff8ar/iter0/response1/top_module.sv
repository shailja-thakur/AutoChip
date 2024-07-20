module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);
    reg [7:0] q_temp; // Temporary register for storing the intermediate values of q

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q_temp <= 8'b0; // Reset the temporary register to 0
        end else begin
            q_temp <= d; // Update the temporary register with input d
        end
    end

    always @(posedge clk) begin
        if (~areset) begin
            q <= q_temp; // Update the output q with the value stored in q_temp on the positive edge of clk
        end
    end
endmodule
