module top_module (
    input clk,
    input a,
    output reg q
);

reg state;

// Define the initial state
initial begin
    state = 0;
    q = 0;
end

always @(posedge clk) begin
    if (a == 1) begin
        state <= ~state;
    end
    q <= state;
end

endmodule
