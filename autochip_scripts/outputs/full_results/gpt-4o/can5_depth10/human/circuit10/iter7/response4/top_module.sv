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
            state <= 1;
        else
            state <= 0;
    end

    always @(posedge clk) begin
        // Update output logic
        if (a == 1 && b == 1)
            q <= ~state;
        else if (a == 1 && b == 0)
            q <= 1;
        else if (a == 0 && b == 1)
            q <= 1;
        else
            q <= 0;
    end
    
endmodule
