module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state; // 2-bit state register

// State definitions
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0; // Reset to initial state
        z <= 0; // Reset output signal
    end else begin
        case (state)
            S0: begin
                if (x == 1'b1) begin
                    state <= S1;
                end
            end
            S1: begin
                if (x == 1'b0) begin
                    state <= S2;
                end else begin
                    state <= S0;
                end
            end
            S2: begin
                if (x == 1'b1) begin
                    state <= S1;
                    z <= 1; // Sequence detected, assert output signal
                end else begin
                    state <= S0;
                end
            end
        endcase
    end
end

endmodule
