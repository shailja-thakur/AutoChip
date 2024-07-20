module top_module(
    input x,
    input y,
    output reg z); // Make "z" a reg type to allow assignments inside an always block

    always @(x, y) begin
        if (x && y)
            z = 1; // Set z to 1 if x and y are both 1
        else
            z = 0; // Otherwise, set z to 0
    end
    
endmodule
