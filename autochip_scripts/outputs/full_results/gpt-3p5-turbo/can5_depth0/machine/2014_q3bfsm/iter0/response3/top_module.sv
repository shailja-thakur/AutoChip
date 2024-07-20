module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001;  // Initializing state to A
        end else begin
            state <= next_state;
        end
    end

    always @(state or x) begin
        case (state)
            3'b001: begin  // State A
                if (x) begin
                    next_state = 3'b010;  // Transition to state B
                end else begin
                    next_state = 3'b001;  // Stay in state A
                end
            end
            3'b010: begin  // State B
                if (x) begin
                    next_state = 3'b100;  // Transition to state E
                end else begin
                    next_state = 3'b010;  // Stay in state B
                end
            end
            3'b011: begin  // State C
                if (x) begin
                    next_state = 3'b010;  // Transition to state B
                end else begin
                    next_state = 3'b011;  // Stay in state C
                end
            end
            3'b100: begin  // State D
                if (x) begin
                    next_state = 3'b011;  // Transition to state C
                end else begin
                    next_state = 3'b010;  // Transition to state B
                end
            end
            3'b101: begin  // State E
                if (x) begin
                    next_state = 3'b101;  // Stay in state E
                end else begin
                    next_state = 3'b100;  // Transition to state D
                end
            end
            default: next_state = 3'b001;  // Default to state A
        endcase
    end

    always @(posedge clk) begin
        if (state == 3'b101 || state == 3'b100) begin
            z <= 1;  // Set output z high when state is D or E
        end else begin
            z <= 0;
        end
    end
endmodule
