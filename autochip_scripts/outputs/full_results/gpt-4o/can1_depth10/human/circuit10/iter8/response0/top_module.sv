module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update state based on inputs a and b
        if (a & b) begin
            state <= ~state;
        end else begin
            state <= state;
        end
        
        // Output q is same as state or based on condition
        q <= (a & b) ? ~q : state;
    end

endmodule
