module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State variables
    reg [1:0] state, next_state;
    
    // State encoding
    parameter A = 2'b01;
    parameter B = 2'b10;
    
    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 1'b0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            B: begin
                if (x == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = B;
                end
            end
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 1'b0;
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

endmodule
