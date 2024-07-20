module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define the state enum
    typedef enum {A, B, C, D} state_type;
    reg [1:0] state, next_state;
    
    // Define the output reg
    reg out_reg;
    
    // Define the state transition logic
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Define the next state and output logic
    always @(state, in)
    begin
        case (state)
            A: begin
                if (in)
                begin
                    next_state <= B;
                    out_reg <= 0;
                end
                else
                begin
                    next_state <= A;
                    out_reg <= 0;
                end
            end
            B: begin
                if (in)
                begin
                    next_state <= B;
                    out_reg <= 0;
                end
                else
                begin
                    next_state <= C;
                    out_reg <= 0;
                end
            end
            C: begin
                if (in)
                begin
                    next_state <= D;
                    out_reg <= 0;
                end
                else
                begin
                    next_state <= A;
                    out_reg <= 0;
                end
            end
            D: begin
                if (in)
                begin
                    next_state <= B;
                    out_reg <= 1;
                end
                else
                begin
                    next_state <= C;
                    out_reg <= 1;
                end
            end
            default: next_state <= A;
        endcase
    end
    
    // Assign the output
    assign out = out_reg;
    
endmodule
