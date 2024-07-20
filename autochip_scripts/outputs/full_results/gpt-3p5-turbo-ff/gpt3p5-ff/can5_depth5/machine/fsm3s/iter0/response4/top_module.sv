module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
reg out_reg;

// Initial state assignment
initial
begin
    state = 2'b00;
end

// Sequential state updates
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= 2'b00;
    else
    begin
        case(state)
            2'b00: // State A
            begin
                if (in)
                    state <= 2'b01; // Transition to state B
                else
                    state <= 2'b00; // Remain in state A
            end
            
            2'b01: // State B
            begin
                if (in)
                    state <= 2'b01; // Remain in state B
                else
                    state <= 2'b10; // Transition to state C
            end
            
            2'b10: // State C
            begin
                if (in)
                    state <= 2'b11; // Transition to state D
                else
                    state <= 2'b00; // Transition to state A
            end
            
            2'b11: // State D
            begin
                if (in)
                    state <= 2'b01; // Transition to state B
                else
                    state <= 2'b10; // Transition to state C
            end
        endcase
    end
end

// Combinational output assignment
always @(state)
begin
    if (state == 2'b11) // State D
        out_reg = 1'b1;
    else
        out_reg = 1'b0;
end

// Assigning output to the registered value
assign out = out_reg;

endmodule
