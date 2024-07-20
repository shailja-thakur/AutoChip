module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset)
        state <= 2'b01; // Initial state B
    else begin
        if (state == 2'b01) begin
            if (in)
                state <= 2'b01; // Next state B
            else
                state <= 2'b10; // Next state A
        end else begin
            if (in)
                state <= 2'b10; // Next state A
            else
                state <= 2'b01; // Next state B
        end
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
