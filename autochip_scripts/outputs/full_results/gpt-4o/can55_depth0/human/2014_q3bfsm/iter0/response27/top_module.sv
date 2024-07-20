module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    
    // Define state variables
    reg [2:0] state, next_state;
    
    // State encoding
    parameter S000 = 3'b000,
              S001 = 3'b001,
              S010 = 3'b010,
              S011 = 3'b011,
              S100 = 3'b100;
    
    // State transition and output logic
    always @(posedge clk) begin
        if (reset)
            state <= S000;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            S000: begin
                if (x)
                    next_state = S001;
                else
                    next_state = S000;
                z = 0;
            end
            S001: begin
                if (x)
                    next_state = S100;
                else
                    next_state = S001;
                z = 0;
            end
            S010: begin
                if (x)
                    next_state = S001;
                else
                    next_state = S010;
                z = 0;
            end
            S011: begin
                if (x)
                    next_state = S010;
                else
                    next_state = S001;
                z = 1;
            end
            S100: begin
                if (x)
                    next_state = S100;
                else
                    next_state = S011;
                z = 1;
            end
            default: begin
                next_state = S000;
                z = 0;
            end
        endcase
    end
    
endmodule
