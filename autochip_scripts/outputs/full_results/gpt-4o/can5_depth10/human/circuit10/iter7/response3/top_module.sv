module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update state logic
        if (a == 1 && b == 1)
            state <= ~state;
        else if (a == 0 && b == 1)
            state <= 1;
        else
            state <= 0;
    end

    always @(posedge clk) begin
        // Update output logic
        q <= state;
    end
    
endmodule
