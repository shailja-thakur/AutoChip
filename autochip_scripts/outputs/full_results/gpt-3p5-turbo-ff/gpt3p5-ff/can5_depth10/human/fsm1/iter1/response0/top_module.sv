module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Initial state B
        else begin
            case (state)
                2'b00: state <= (in) ? 2'b00 : 2'b01; // Transition from A to A or B based on input
                2'b01: state <= (in) ? 2'b00 : 2'b01; // Transition from B to A or B based on input
            endcase
        end
    end

    always @(state) begin
        out = (state == 2'b00) ? 1'b0 : 1'b1; // Output is 0 when in state A else 1
    end

endmodule
