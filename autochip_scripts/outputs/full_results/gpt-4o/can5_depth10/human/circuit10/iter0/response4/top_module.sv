module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg next_state;

// Define the sequential logic
always @(posedge clk) begin
    state <= next_state;
end

// Define the combinational logic to determine next_state and q
always @(*) begin
    if (a == 1'b1 && b == 1'b1) begin
        next_state = ~state;
    end else if (a == 1'b1 && b == 1'b0) begin
        next_state = state;
    end else if (a == 1'b0 && b == 1'b1) begin
        next_state = state;
    end else begin
        next_state = state;
    end
    q = next_state;
end

endmodule
