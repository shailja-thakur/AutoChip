module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001;  // Initializing state to A
            z <= 1'b0;        // Initializing output to low
        end else begin
            case (state)
                3'b001: begin  // State A
                    if (x) begin
                        state <= 3'b010;  // Next state is B
                    end else begin
                        state <= 3'b001;  // Next state is A
                    end
                end
                3'b010: begin  // State B
                    if (x) begin
                        state <= 3'b101;  // Next state is E
                    end else begin
                        state <= 3'b010;  // Next state is B
                    end
                end
                3'b011: begin  // State C
                    if (x) begin
                        state <= 3'b010;  // Next state is B
                    end else begin
                        state <= 3'b011;  // Next state is C
                    end
                end
                3'b100: begin  // State D
                    if (x) begin
                        state <= 3'b011;  // Next state is C
                    end else begin
                        state <= 3'b010;  // Next state is B
                    end
                end
                3'b101: begin  // State E
                    if (x) begin
                        state <= 3'b101;  // Next state is E
                    end else begin
                        state <= 3'b100;  // Next state is D
                    end
                end
                default: state <= 3'b001;  // Default to state A
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b101 || state == 3'b110) begin
            z <= 1'b1;  // Output is high for states D and E
        end else begin
            z <= 1'b0;
        end
    end

endmodule
