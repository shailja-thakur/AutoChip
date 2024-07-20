module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00;  // Reset to state A
    end else begin
        case (state)
            2'b00: begin  // State A
                if (in == 1)
                    state <= 2'b01;  // Next state is B
                else
                    state <= 2'b00;  // Next state is A
            end
            2'b01: begin  // State B
                if (in == 1)
                    state <= 2'b01;  // Next state is B
                else
                    state <= 2'b10;  // Next state is C
            end
            2'b10: begin  // State C
                if (in == 1)
                    state <= 2'b11;  // Next state is D
                else
                    state <= 2'b00;  // Next state is A
            end
            2'b11: begin  // State D
                if (in == 1)
                    state <= 2'b01;  // Next state is B
                else
                    state <= 2'b10;  // Next state is C
            end
        endcase
    end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;  // Set out to 1 when state is D

endmodule
