module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    
    // State definitions
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;
    
    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (in) next_state = B;
                else next_state = A;
            end
            B: begin
                if (in) next_state = B;
                else next_state = C;
            end
            C: begin
                if (in) next_state = D;
                else next_state = A;
            end
            D: begin
                if (in) next_state = B;
                else next_state = C;
            end
            default: next_state = A;
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        if (state == D)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
