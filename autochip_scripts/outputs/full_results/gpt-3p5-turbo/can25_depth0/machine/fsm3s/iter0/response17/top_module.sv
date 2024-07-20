module fsm_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;    // Reset state to A
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            2'b00: begin    // State A
                if (in) begin
                    next_state = 2'b01;    // Transition to state B
                end else begin
                    next_state = 2'b00;    // Remain in state A
                end
            end
            
            2'b01: begin    // State B
                if (in) begin
                    next_state = 2'b01;    // Remain in state B
                end else begin
                    next_state = 2'b10;    // Transition to state C
                end
            end
            
            2'b10: begin    // State C
                if (in) begin
                    next_state = 2'b11;    // Transition to state D
                end else begin
                    next_state = 2'b00;    // Transition to state A
                end
            end
            
            2'b11: begin    // State D
                if (in) begin
                    next_state = 2'b01;    // Transition to state B
                end else begin
                    next_state = 2'b10;    // Transition to state C
                end
            end
        endcase
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;    // Set output to 1 when state is D, otherwise 0
    
endmodule
module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    fsm_module fsm_inst (
        .clk(clk),
        .in(in),
        .reset(reset),
        .out(out)
    );
    
endmodule
