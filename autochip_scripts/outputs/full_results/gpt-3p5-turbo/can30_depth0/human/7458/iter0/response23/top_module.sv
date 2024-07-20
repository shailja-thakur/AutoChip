module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

    reg p1y_wire;
    reg p2y_wire;
    
    assign p1y = p1y_wire;
    assign p2y = p2y_wire;
    
    always @(*) begin
        p1y_wire = (p1a & p1b & p1c) | (p1d & p1e & p1f);
        p2y_wire = (p2a & p2b) | (p2c & p2d);
    end

endmodule
