module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state, next_state;

    // Define the states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    // Define the outputs
    parameter OUTPUT_ZERO = 1'b0;
    parameter OUTPUT_ONE = 1'b1;
    
    // Define the state transition table
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            A: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
                out = OUTPUT_ZERO;
            end
            
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
                out = OUTPUT_ZERO;
            end
            
            C: begin
                if (in) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
                out = OUTPUT_ZERO;
            end
            
            D: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
                out = OUTPUT_ONE;
            end
        endcase
    end

endmodule
