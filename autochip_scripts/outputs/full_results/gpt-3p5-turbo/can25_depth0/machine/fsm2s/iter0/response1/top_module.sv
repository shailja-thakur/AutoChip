module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State register
    reg [1:0] state;

    // State assignments
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else if (state == 2'b00 && j)
            state <= 2'b01;
        else if (state == 2'b01 && k)
            state <= 2'b00;
        else
            state <= state;
    end

    // Output assignment
    always @(state) begin
        if (state == 2'b01)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
