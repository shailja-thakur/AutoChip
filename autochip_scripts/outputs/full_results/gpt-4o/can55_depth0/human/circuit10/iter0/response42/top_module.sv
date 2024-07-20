module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    // State logic based on the behavior observed from the timing diagram
    if (a == 1 && b == 1) begin
        state <= state;
    end else if (a == 1 && b == 0) begin
        state <= 0;
    end else if (a == 0 && b == 1) begin
        state <= 1;
    end else begin // a == 0 && b == 0
        state <= state;
    end

    // Output logic q is simply following the state
    q <= state;
end

endmodule
