module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk) begin    
        if (reset) begin
            state <= 2'b1;  // Initialize to state B when reset signal is active high
        end else begin
            case (state)
                2'b00: begin  // State B
                    if (in) begin
                        state <= 2'b00;  // Remain in state B when input is 1
                    end else begin
                        state <= 2'b01;  // Transition to state A when input is 0
                    end
                end
                2'b01: begin  // State A
                    if (in) begin
                        state <= 2'b01;  // Remain in state A when input is 1
                    end else begin
                        state <= 2'b00;  // Transition to state B when input is 0
                    end
                end
                default: begin
                    state <= 2'b1;  // Default state is B
                end
            endcase
        end
    end
    
    assign out = (state == 2'b00) ? 1'b1 : 1'b0;

endmodule
