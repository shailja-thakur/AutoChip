module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	reg [2:0] state;
	
	
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case(state)
                3'b000: begin // State A
                    if (w) begin
                        state <= 3'b001; // Transition to state B
                    end else begin
                        state <= 3'b000; // Remain in state A
                    end
                end
                3'b001: begin // State B
                    if (w) begin
                        state <= 3'b010; // Transition to state C
                    end else begin
                        state <= 3'b011; // Transition to state D
                    end
                end
                3'b010: begin // State C
                    if (w) begin
                        state <= 3'b100; // Transition to state E
                    end else begin
                        state <= 3'b011; // Transition to state D
                    end
                end
                3'b011: begin // State D
                    if (w) begin
                        state <= 3'b101; // Transition to state F
                    end else begin
                        state <= 3'b000; // Transition to state A
                    end
                end
                3'b100: begin // State E
                    if (w) begin
                        state <= 3'b100; // Remain in state E
                    end else begin
                        state <= 3'b011; // Transition to state D
                    end
                end
                3'b101: begin // State F
                    if (w) begin
                        state <= 3'b010; // Transition to state C
                    end else begin
                        state <= 3'b011; // Transition to state D
                    end
                end
                default: begin
                    state <= 3'b000; // Default state is A
                end
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            3'b000: begin // State A
                z <= 1'b0;
            end
            3'b001: begin // State B
                z <= 1'b0;
            end
            3'b010: begin // State C
                z <= 1'b0;
            end
            3'b011: begin // State D
                z <= 1'b0;
            end
            3'b100: begin // State E
                z <= 1'b1;
            end
            3'b101: begin // State F
                z <= 1'b1;
            end
            default: begin
                z <= 1'b0; // Default state is A
            end
        endcase
    end
endmodule
