module top_module (
    input logic clk,
    input logic d,
    input logic r,
    output logic q
);

    logic q_reg;

    always_ff @(posedge clk) begin
        if (r)
            q_reg <= 0; // reset
        else
            q_reg <= d; // store data input
    end

    assign q = q_reg;

endmodule
