module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // State A
        end
        else begin
            case (state)
                2'b00: // State A
                    if (in) begin
                        state <= 2'b01; // Next state is B
                    end
                    else begin
                        state <= 2'b00; // Remain in state A
                    end
                2'b01: // State B
                    if (in) begin
                        state <= 2'b01; // Remain in state B
                    end
                    else begin
                        state <= 2'b10; // Next state is C
                    end
                2'b10: // State C
                    if (in) begin
                        state <= 2'b11; // Next state is D
                    end
                    else begin
                        state <= 2'b00; // Next state is A
                    end
                2'b11: // State D
                    if (in) begin
                        state <= 2'b01; // Next state is B
                    end
                    else begin
                        state <= 2'b10; // Next state is C
                    end
            endcase
        end
    end
    
    always @(state) begin
        if (state == 2'b11) begin // State D
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end

endmodule
