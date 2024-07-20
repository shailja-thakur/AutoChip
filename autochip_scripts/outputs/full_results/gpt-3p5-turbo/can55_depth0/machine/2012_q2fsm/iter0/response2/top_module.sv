module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;  // State register
    
    // Combinational logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;  // Set initial state to A
        end else begin
            case (state)
                3'b000: begin  // State A
                    if (w) begin
                        state <= 3'b001;  // Transition to B
                    end else begin
                        state <= 3'b000;  // Transition to A
                    end
                end
                3'b001: begin  // State B
                    if (w) begin
                        state <= 3'b010;  // Transition to C
                    end else begin
                        state <= 3'b100;  // Transition to D
                    end
                end
                3'b010: begin  // State C
                    if (w) begin
                        state <= 3'b100;  // Transition to E
                    end else begin
                        state <= 3'b100;  // Transition to D
                    end
                end
                3'b100: begin  // State D
                    if (w) begin
                        state <= 3'b111;  // Transition to F
                    end else begin
                        state <= 3'b000;  // Transition to A
                    end
                end
                3'b011: begin  // State E
                    if (w) begin
                        state <= 3'b011;  // Transition to E
                    end else begin
                        state <= 3'b100;  // Transition to D
                    end
                end
                3'b111: begin  // State F
                    if (w) begin
                        state <= 3'b010;  // Transition to C
                    end else begin
                        state <= 3'b100;  // Transition to D
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end

    // Assign statement for output z
    assign z = (state == 3'b011) || (state == 3'b111);

endmodule
