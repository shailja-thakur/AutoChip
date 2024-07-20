module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Internal state
    reg [2:0] state;

    // State machine logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state A
        end else begin
            case (state)
                3'b000: begin // State A
                    if (x) begin
                        state <= 3'b001; // Next state B
                    end else begin
                        state <= 3'b000; // Next state A
                    end
                end

                3'b001: begin // State B
                    if (x) begin
                        state <= 3'b100; // Next state E
                    end else begin
                        state <= 3'b001; // Next state B
                    end
                end

                3'b010: begin // State C
                    if (x) begin
                        state <= 3'b001; // Next state B
                    end else begin
                        state <= 3'b010; // Next state C
                    end
                end

                3'b011: begin // State D
                    if (x) begin
                        state <= 3'b010; // Next state C
                    end else begin
                        state <= 3'b001; // Next state B
                    end
                end

                3'b100: begin // State E
                    if (x) begin
                        state <= 3'b100; // Next state E
                    end else begin
                        state <= 3'b011; // Next state D
                    end
                end
            endcase
        end
    end

    // Output logic
    always @(state) begin
        case (state)
            3'b011, 3'b100: begin
                z <= 1'b1; // Output is high for states D and E
            end
            default: begin
                z <= 1'b0; // Output is low for all other states
            end
        endcase
    end
endmodule
