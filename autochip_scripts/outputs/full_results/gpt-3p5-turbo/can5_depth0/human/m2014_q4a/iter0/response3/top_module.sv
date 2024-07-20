module top_module (
    input d,
    input ena,
    output logic q
);

    // Define internal wire signals
    wire not_d;
    wire not_ena;
    
    // Combinational logic for inverting signals
    assign not_d = ~d;
    assign not_ena = ~ena;
    
    // D latch implementation using an always block
    always @(posedge ena)
    begin
        if (not_ena)
            q <= q;
        else
            q <= not_d;
    end
    
endmodule
