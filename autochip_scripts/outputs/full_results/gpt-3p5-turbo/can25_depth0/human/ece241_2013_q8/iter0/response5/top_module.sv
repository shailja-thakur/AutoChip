module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;

// Define state values
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        // Asynchronous reset
        state <= S0;
    end else begin
        // State transition logic
        case (state)
            S0: begin
                // State S0 transition conditions
                if (x == 1'b1) begin
                    state <= S1;
                end else begin
                    state <= S0;
                end
            end
            
            S1: begin
                // State S1 transition conditions
                if (x == 1'b0) begin
                    state <= S0;
                end else begin
                    state <= S2;
                end
            end
            
            S2: begin
                // State S2 transition conditions
                if (x == 1'b1) begin
                    state <= S0;
                    z <= 1'b1; // Sequence detected, assert output signal z to logic 1
                end else begin
                    state <= S0;
                end
            end
        endcase
    end
end

endmodule
