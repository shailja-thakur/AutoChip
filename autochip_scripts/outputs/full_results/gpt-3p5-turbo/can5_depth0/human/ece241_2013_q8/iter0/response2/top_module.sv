module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg [1:0] input_buffer;

parameter S0 = 3'd0;
parameter S1 = 3'd1;
parameter S2 = 3'd2;

always @(negedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
        input_buffer <= 2'b0;
        z <= 1'b0;
    end else begin
        case (state)
            S0: begin
                if (x == 1'b1) begin
                    input_buffer <= {input_buffer[0], x};
                    if (input_buffer == 2'b10)
                        state <= S1;
                end
            end
            S1: begin
                if (x == 1'b1) begin
                    input_buffer <= {input_buffer[0], x};
                    if (input_buffer == 2'b01)
                        state <= S2;
                else
                    state <= S0;
                end
            end
            S2: begin
                if (x == 1'b1) begin
                    input_buffer <= {input_buffer[0], x};
                    if (input_buffer == 2'b10) begin
                        state <= S1;
                        z <= 1'b1; // Sequence detected, assert z
                    end
                else
                    state <= S0;
                end
            end
        endcase
    end
end

endmodule
