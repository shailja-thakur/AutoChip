module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b001; // Initializing state to A
        end
        else begin
            case (state)
                3'b000: begin // State A
                    if (x) begin
                        state <= 3'b010; // Transition to state B
                    end
                    else begin
                        state <= 3'b000; // Stay in state A
                    end
                end
                
                3'b010: begin // State B
                    if (x) begin
                        state <= 3'b101; // Transition to state E
                    end
                    else begin
                        state <= 3'b010; // Stay in state B
                    end
                end
                
                3'b001: begin // State C
                    if (x) begin
                        state <= 3'b010; // Transition to state B
                    end
                    else begin
                        state <= 3'b001; // Stay in state C
                    end
                end
                
                3'b011: begin // State D
                    if (x) begin
                        state <= 3'b001; // Transition to state C
                    end
                    else begin
                        state <= 3'b010; // Transition to state B
                    end
                end
                
                3'b100: begin // State E
                    if (x) begin
                        state <= 3'b100; // Stay in state E
                    end
                    else begin
                        state <= 3'b011; // Transition to state D
                    end
                end
                
                default: state <= 3'b001; // Default case is to initialize to state A
            endcase
        end
    end


    always @(state) begin
        if (state == 3'b011 || state == 3'b100) begin
            z = 1'b1; // Output is high for state D and E
        end
        else begin
            z = 1'b0; // Output is low for other states
        end
    end

endmodule
