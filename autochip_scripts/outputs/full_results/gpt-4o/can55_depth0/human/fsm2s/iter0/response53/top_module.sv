module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;
    
    reg state, next_state;

    // State transition logic (combinatorial)
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON; 
                 else next_state = OFF;
            ON:  if (k) next_state = OFF; 
                 else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State register (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(state) begin
        case (state)
            OFF: out = 0;
            ON:  out = 1;
            default: out = 0;
        endcase
    end
endmodule
