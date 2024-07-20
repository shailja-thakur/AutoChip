module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Parameterized register to store the current state
    reg [1:0] state;

    // Combinational logic block to determine next state
    always @(*) begin
        if (state == 2'b00) begin
            if (in)
                state <= 2'b00;
            else
                state <= 2'b01;
        end else begin
            if (in)
                state <= 2'b01;
            else
                state <= 2'b00;
        end
    end

    // Update state register on the rising edge of clk
    always @(posedge clk) begin
        if (reset)
            state <= 2'b01;
        else
            state <= state;
    end

    // Assign out output based on state register
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
