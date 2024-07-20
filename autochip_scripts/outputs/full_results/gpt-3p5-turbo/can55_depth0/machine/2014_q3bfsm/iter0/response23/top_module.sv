module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b001; // Initialize state to A
        else begin
            case (state)
                3'b001: // State A
                    if (x)
                        state <= 3'b010; // Next state is B
                    else
                        state <= 3'b001; // Next state is A
                    
                3'b010: // State B
                    if (x)
                        state <= 3'b101; // Next state is E
                    else
                        state <= 3'b010; // Next state is B
                    
                3'b011: // State C
                    if (x)
                        state <= 3'b010; // Next state is B
                    else
                        state <= 3'b011; // Next state is C
                        
                3'b100: // State D
                    if (x)
                        state <= 3'b011; // Next state is C
                    else 
                        state <= 3'b010; // Next state is B
                        
                3'b101: // State E
                    if (x)
                        state <= 3'b101; // Next state is E
                    else
                        state <= 3'b100; // Next state is D
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            3'b100, 3'b101: // States D and E
                z <= 1'b1; // Output is high
            default:
                z <= 1'b0; // Output is low
        endcase
    end

endmodule
