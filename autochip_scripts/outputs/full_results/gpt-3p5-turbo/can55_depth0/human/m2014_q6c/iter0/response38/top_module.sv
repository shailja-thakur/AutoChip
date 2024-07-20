module top_module ( input [6:1] y, input w, output Y2, output Y4 );

    // State A
    assign Y2 = (y[1]) ? 1'b0 : 1'b0;
    assign Y4 = (y[1]) ? 1'b0 : 1'b0;

    // State B
    assign Y2 = (y[2] | y[3]) ? 1'b0 : 1'b0;
    assign Y4 = (y[2]) ? 1'b0 : 1'b0;
      
    // State C
    assign Y2 = (y[3] | y[5]) ? 1'b0 : 1'b0;
    assign Y4 = (y[3]) ? 1'b0 : 1'b0;
      
    // State D
    assign Y2 = (y[4] | y[1] | y[6]) ? 1'b0 : 1'b0;
    assign Y4 = (y[4]) ? 1'b0 : 1'b0;
      
    // State E
    assign Y2 = (y[5] | y[6]) ? 1'b0 : 1'b0;
    assign Y4 = (y[5]) ? 1'b1 : 1'b0;
      
    // State F
    assign Y2 = (y[6] | y[3] | y[5]) ? 1'b1 : 1'b0;
    assign Y4 = (y[6]) ? 1'b0 : 1'b0;
      
endmodule
