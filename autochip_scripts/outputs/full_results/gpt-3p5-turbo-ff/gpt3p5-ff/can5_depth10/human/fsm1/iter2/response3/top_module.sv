module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Initial state B
        else begin
            case (state)
                2'b00: state <= (in) ? 2'b00 : 2'b01; // Transition from A to B or A based on input
                2'b01: state <= (in) ? 2'b01 : 2'b00; // Transition from B to A or B based on input
            endcase
        end
    end

    assign out = (state == 2'b00) ? 1'b1 : 1'b0; // Output is 1 when in state A else 0

endmodule
