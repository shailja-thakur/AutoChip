module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to state B
        end else begin
            case (state)
                2'b00: begin
                    if (in) begin
                        state <= 2'b00; // Continue to state A
                    end else begin
                        state <= 2'b01; // Transition to state B
                    end
                end
                2'b01: begin
                    if (in) begin
                        state <= 2'b00; // Transition to state A
                    end else begin
                        state <= 2'b01; // Continue to state B
                    end
                end
            endcase
        end
    end
    
    assign out = (state == 2'b00) ? 1'b1 : 1'b0;
    
endmodule
