module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

// Register declaration
logic [31:0] reg;

// Always block - triggered on rising edge of clock or asynchronous reset
always_ff @(posedge clk or negedge ar) begin
    if (!ar) // Asynchronous reset triggered
        reg <= 0;
    else if (clk) // Clock triggered
        reg <= d;
end

// Assign output
assign q = reg;

endmodule
