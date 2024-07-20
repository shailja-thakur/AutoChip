module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg [1:0] state;
    reg [1:0] next_state;
    
    localparam A = 2'b01;
    localparam B = 2'b10;
    
    // State transition and output logic
    always @(*) begin
        case (state)
            A: begin
                z = x;
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                z = ~x;
                if (x)
                    next_state = B;
                else
                    next_state = B;
            end
            default: begin
                z = 0;
                next_state = A;
            end
        endcase
    end
    
    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
