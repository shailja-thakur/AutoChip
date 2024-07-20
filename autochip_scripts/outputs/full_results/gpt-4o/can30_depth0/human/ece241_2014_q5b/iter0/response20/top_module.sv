module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declaration using one-hot encoding
    reg [1:0] state;
    reg [1:0] next_state;
    
    // State encoding
    localparam A = 2'b01;
    localparam B = 2'b10;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = state;
        z = 1'b0;
        
        case (state)
            A: begin
                if (x == 1'b0) begin
                    next_state = A;
                    z = 1'b0;
                end else begin
                    next_state = B;
                    z = 1'b1;
                end
            end 
            B: begin
                if (x == 1'b0) begin
                    next_state = B;
                    z = 1'b1;
                end else begin
                    next_state = B;
                    z = 1'b0;
                end
            end
        endcase
    end

endmodule
