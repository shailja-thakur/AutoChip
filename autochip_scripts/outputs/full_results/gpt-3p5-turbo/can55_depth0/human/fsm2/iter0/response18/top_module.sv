module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0; // Set initial state to OFF
        end else begin
            case (state)
                2'b00: begin
                    if (j) begin
                        state <= 2'b01; // Transition to ON state if j is 1
                    end else begin
                        state <= 2'b00; // Stay in OFF state if j is 0
                    end
                end
                2'b01: begin
                    if (k) begin
                        state <= 2'b00; // Transition to OFF state if k is 1
                    end else begin
                        state <= 2'b01; // Stay in ON state if k is 0
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: begin
                out <= 1'b0; // Output is 0 in OFF state
            end
            2'b01: begin
                out <= 1'b1; // Output is 1 in ON state
            end
        endcase
    end

endmodule
