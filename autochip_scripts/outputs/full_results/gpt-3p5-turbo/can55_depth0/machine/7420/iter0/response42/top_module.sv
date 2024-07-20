module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);
    
    wire n_p1a, n_p1b, n_p1c, n_p1d, n_p2a, n_p2b, n_p2c, n_p2d;
    
    assign n_p1a = ~p1a;
    assign n_p1b = ~p1b;
    assign n_p1c = ~p1c;
    assign n_p1d = ~p1d;
    
    assign n_p2a = ~p2a;
    assign n_p2b = ~p2b;
    assign n_p2c = ~p2c;
    assign n_p2d = ~p2d;
    
    assign p1y = n_p1a & n_p1b & n_p1c & n_p1d;
    assign p2y = n_p2a & n_p2b & n_p2c & n_p2d;
    
endmodule
