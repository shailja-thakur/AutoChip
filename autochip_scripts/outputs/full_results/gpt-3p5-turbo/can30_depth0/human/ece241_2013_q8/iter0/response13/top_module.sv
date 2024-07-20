module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg [2:0] sequence_counter;

parameter S0 = 2'b00; // Initial state
parameter S1 = 2'b01; // State after receiving 1
parameter S2 = 2'b10; // State after receiving 10

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0; // Reset to initial state
        sequence_counter <= 0;
        z <= 0;
    end else begin
        case (state)
            S0: begin
                if (x == 1'b1) begin
                    state <= S1;
                end else begin
                    state <= S0;
                end
            end

            S1: begin
                if (x == 1'b0) begin
                    state <= S2;
                end else begin
                    state <= S1;
                end
            end

            S2: begin
                if (x == 1'b1) begin
                    state <= S1;
                    sequence_counter <= sequence_counter + 1;
                end else begin
                    state <= S0;
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (sequence_counter == 3) begin
        z <= 1;
    end
end

endmodule
