module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Derive the Verilog expressions for Y1 and Y3 based on the given state machine and one-hot encoding

assign Y1 = (y[0] & w) | // A --> B
           (y[3] & ~w) | // D --> A
           (y[4] & ~w); // E --> D

assign Y3 = (y[1] & w) | // B --> C
           (y[1] & ~w) | // B --> D
           (y[2] & ~w) | // C --> D
           (y[3] & w);  // D --> F

endmodule
