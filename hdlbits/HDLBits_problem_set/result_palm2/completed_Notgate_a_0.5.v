module top_module( input in, output out );

    logic in;
    logic out;

    always @(in)
        out <= !in;

endmodule