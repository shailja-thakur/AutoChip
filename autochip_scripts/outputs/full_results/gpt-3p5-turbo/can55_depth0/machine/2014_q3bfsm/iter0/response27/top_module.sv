module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 3'b001; // Initializing state to A
    end else begin
        case(state)
            3'b000: begin // State A
                if (x) begin // Transition to B if x is high
                    state <= 3'b001;
                end else begin // Stay in A if x is low
                    state <= 3'b000;
                end
            end
            3'b001: begin // State B
                if (x) begin // Transition to E if x is high
                    state <= 3'b100;
                end else begin // Stay in B if x is low
                    state <= 3'b001;
                end
            end
            3'b010: begin // State C
                if (x) begin // Transition to B if x is high
                    state <= 3'b001;
                end else begin // Stay in C if x is low
                    state <= 3'b010;
                end
            end
            3'b011: begin // State D
                if (x) begin // Transition to C if x is high
                    state <= 3'b010;
                end else begin // Stay in D if x is low
                    state <= 3'b001;
                end
            end
            3'b100: begin // State E
                if (x) begin // Stay in E if x is high
                    state <= 3'b100;
                end else begin // Transition to D if x is low
                    state <= 3'b011;
                end
            end
            default: begin
                state <= 3'b001; // Default to A state
            end
        endcase
    end
end

// Output is high when state is D or E
always @(state) begin
    case(state)
        3'b011, 3'b100: begin
            z <= 1;
        end
        default: begin
            z <= 0;
        end
    endcase
end

endmodule
