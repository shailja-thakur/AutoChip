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
        else if (a == 1 && b == 0)
            state <= 0;
    end

    always @(posedge clk) begin
        // Update output logic
        if (a == 1 && b == 1)
            q <= 0;
        else if (a == 1)
            q <= b;
    end
    
endmodule
