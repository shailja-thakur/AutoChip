module top_module(
    input x,
    input y,
    output z);

    wire x_delayed;
    reg z_reg;

    always@(x or y)
    begin
        // Delay x by 5ns
        #5 x_delayed = x;
        
        // Implement the logic for z based on the given waveform
        if (x_delayed == 1'b1 && y == 1'b1)
            z_reg = 1'b1;
        else if (x_delayed == 1'b0 && y == 1'b0)
            z_reg = 1'b1;
        else if (x_delayed == 1'b0 && y == 1'b1)
            z_reg = 1'b0;
        else
            z_reg = 1'b0;
        
        // Delay z by 5ns
        #5 z = z_reg;
    end
    
endmodule
