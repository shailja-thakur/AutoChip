module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Create a temporary register to store the next state
        reg [511:0] next_state;

        // Compute the next state using the Rule 90 logic
        for (int i = 0; i < 512; i++) begin
            next_state[i] = q[i] ^ ((i == 0) ? 0 : q[i-1]) ^ ((i == 511) ? 0 : q[i+1]);
        end

        // Update the state
        q <= next_state;
    end
end

endmodule
