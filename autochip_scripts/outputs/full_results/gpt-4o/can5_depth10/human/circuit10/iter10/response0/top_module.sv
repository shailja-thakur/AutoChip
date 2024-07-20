module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update state based on input a
        state <= a;

        // Update q based on the state and input b
        if (b) begin
            q <= ~state;
        end else begin
            q <= state;
        end
    end

endmodule
