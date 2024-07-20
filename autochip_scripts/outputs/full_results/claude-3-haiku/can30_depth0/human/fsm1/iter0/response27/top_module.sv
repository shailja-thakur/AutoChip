module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    
    localparam A = 2'b00;
    localparam B = 2'b01;
    
    // State transition logic
    always @(*) begin
        case (state)
            B: begin
                if (in == 0) next_state = A;
                else next_state = B;
            end
            A: begin
                if (in == 0) next_state = B;
                else next_state = A;
            end
            default: next_state = B;
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) state <= B;
        else state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 0;
        endcase
    end

endmodule
